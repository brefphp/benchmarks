<?php

namespace App;

use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\HttpKernel\Kernel as BaseKernel;
use Symfony\Bundle\FrameworkBundle\Kernel\MicroKernelTrait;
use Symfony\Component\Routing\Loader\Configurator\RoutingConfigurator;
use Symfony\Component\DependencyInjection\Loader\Configurator\ContainerConfigurator;

class Kernel extends BaseKernel
{
    use MicroKernelTrait;

    public function getLogDir()
    {
        // When on the lambda only /tmp is writeable
        if (getenv('LAMBDA_TASK_ROOT') !== false) {
            return '/tmp/log/';
        }

        return $this->getProjectDir().'/var/log';
    }

    /**
     * {@inheritdoc}
     */
    public function boot(): void
    {
        // When on the lambda, copy the cache dir over to /tmp where it is writable
        if (isset($_SERVER['LAMBDA_TASK_ROOT']) && !is_dir($this->getCacheDir())) {
            $this->prepareCacheDir(parent::getCacheDir(), $this->getCacheDir());
        }

        parent::boot();
    }

    public function getCacheDir()
    {
        // When on the lambda only /tmp is writeable
        if (getenv('LAMBDA_TASK_ROOT') !== false) {
            return '/tmp/cache/'.$this->environment;
        }

        return $this->getProjectDir().'/var/cache/'.$this->environment;
    }

    protected function configureContainer(ContainerConfigurator $container): void
    {
        $container->import('../config/{packages}/*.yaml');
        $container->import('../config/{packages}/'.$this->environment.'/*.yaml');

        if (is_file(\dirname(__DIR__).'/config/services.yaml')) {
            $container->import('../config/{services}.yaml');
            $container->import('../config/{services}_'.$this->environment.'.yaml');
        } elseif (is_file($path = \dirname(__DIR__).'/config/services.php')) {
            (require $path)($container->withPath($path), $this);
        }
    }

    protected function configureRoutes(RoutingConfigurator $routes): void
    {
        $routes->import('../config/{routes}/'.$this->environment.'/*.yaml');
        $routes->import('../config/{routes}/*.yaml');

        if (is_file(\dirname(__DIR__).'/config/routes.yaml')) {
            $routes->import('../config/{routes}.yaml');
        } elseif (is_file($path = \dirname(__DIR__).'/config/routes.php')) {
            (require $path)($routes->withPath($path), $this);
        }
    }

    private function prepareCacheDir(string $readOnlyDir, string $writeDir): void
    {
        if (!is_dir($readOnlyDir)) {
            return;
        }

        $startTime = microtime(true);
        $cacheDirectoriesToCopy = $this->getWritableCacheDirectories();
        $filesystem = new Filesystem();
        $filesystem->mkdir($writeDir);

        $scandir = scandir($readOnlyDir, SCANDIR_SORT_NONE);
        if (false === $scandir) {
            return;
        }

        foreach ($scandir as $item) {
            if (in_array($item, ['.', '..'], true)) {
                continue;
            }

            // Copy directories to a writable space on Lambda.
            if (in_array($item, $cacheDirectoriesToCopy, true)) {
                $filesystem->mirror("{$readOnlyDir}/{$item}", "{$writeDir}/{$item}");

                continue;
            }

            // Symlink all other directories
            // This is especially important with the Container* directories since it uses require_once statements
            if (is_dir("{$readOnlyDir}/{$item}")) {
                $filesystem->symlink("{$readOnlyDir}/{$item}", "{$writeDir}/{$item}");

                continue;
            }

            // Copy all other files.
            $filesystem->copy("{$readOnlyDir}/{$item}", "{$writeDir}/{$item}");
        }

        $this->logToStderr(sprintf(
            'Symfony cache directory prepared in %s ms.',
            number_format((microtime(true) - $startTime) * 1000, 2)
        ));
    }

    /**
     * Return the pre-warmed directories in var/cache/[env] that should be copied to
     * a writable directory in the Lambda environment.
     *
     * For optimal performance one should prewarm the cache folder and override this
     * function to return an empty array.
     *
     * @return array<string>
     */
    private function getWritableCacheDirectories(): array
    {
        return ['pools'];
    }

    /**
     * This method logs to stderr.
     *
     * It must only be used in a lambda environment since all error output will be logged.
     *
     * @param string $message The message to log
     */
    private function logToStderr(string $message): void
    {
        file_put_contents('php://stderr', date('[c] ').$message.PHP_EOL, FILE_APPEND);
    }
}
