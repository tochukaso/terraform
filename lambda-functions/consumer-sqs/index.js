/**
 * Lambdaメインファンクション.
 */
exports.handle = (event) => {
  console.log(event);
  const body = JSON.parse(event.Records[0].body);
  console.log(body);
  console.log(event.Records[0].attributes[0]);
  console.log(JSON.stringify(event.Records[0].attributes[0]));

  if (body.is_success) {
    console.log('event succeed');
    return;
  }

  const error = new Error("retry Error");
  throw error;
};
