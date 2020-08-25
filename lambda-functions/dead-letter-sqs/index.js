const AWS = require("aws-sdk");
const sqs = new AWS.SQS();


const sendMessage = (data) => {
  return new Promise((resolve, reject) => {
    const params = {
      MessageBody: data,
      QueueUrl: process.env.SQS_QUEUE_URL
    };

    console.info("sendMessage" + JSON.stringify(params));
    sqs.sendMessage(params, (err, data) => {
      if (err) {
        console.error("sendMessage was errored");
        console.error(err, err.stack);
        reject(err);
      } else {
        console.info("sendMessage response: " + JSON.stringify(data));
        resolve();
      }
    });
  });
};

/**
 * Lambdaメインファンクション.
 */
exports.handle = (event) => {
  console.log(event);

  Promise.resolve()
    .then(() => {
      sendMessage(event.Records[0].body);
    })
    .catch((errorResult) => {
      console.error(`${JSON.stringify(errorResult)}`);
      console.info("***** End *****");
      throw(errorResult);
    });
};
