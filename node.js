'use strict';

module.exports.handle = (event, context, callback) => {
    callback(null, {
        statusCode: 200,
        body: JSON.stringify({
            message: 'OK',
        }),
    });
};
