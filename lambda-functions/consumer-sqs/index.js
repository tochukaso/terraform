/**
 * Lambdaメインファンクション.
 */
exports.handler = async (event) => {
  console.log(event);
  const body = JSON.parse(event.Records[0].body)
  console.log(body);

  if (body.is_success) {
    console.log('event succeed');
    return;
  }

  const error = new Error("retry Error");
  throw error;
};
