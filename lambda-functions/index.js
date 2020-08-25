const request = require("request");

const callback = (data) => {
  return new Promise((resolve, reject) => {

    request.put('http://localhost:4000/v1/aibs0710/face_detection/aadac053e7b79dc34ff612b52dfc67fcc6/job/24k6h6gmdjbadluwdbltcrzv6y/_callback')
    .on('response', function(response) {
      console.log(response.statusCode);
      console.log(response.headers['content-type']);
    })
  });
};

/**
 * Lambdaメインファンクション.
 */
exports.handle = (event) => {
  console.log(event);

  Promise.resolve()
    .then(() => {
      callback(event.Records[0].body);
    })
    .catch((errorResult) => {
      console.error(`${JSON.stringify(errorResult)}`);
      console.info("***** End *****");
      throw (errorResult);
    });
};
