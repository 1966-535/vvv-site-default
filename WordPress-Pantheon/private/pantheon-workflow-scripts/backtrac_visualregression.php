<?php

// An example of usign Pantheon's Quicksilver technology to do
// automatic visual regression testing using Backtrac.io

// Provide the API Key provided by Backtrac.io
$api_key = 'b4a6eb2992e83b1a969931da3a32a7b3';

// Provide the Project ID for the project on Backtrac.io
$project_id = 'live-otestsite.pantheonsite.io';

// If we are deploying to test, run a visual regression test
// between the production environment and the testing environment.
if (defined('PANTHEON_ENVIRONMENT') && (PANTHEON_ENVIRONMENT == 'test')) {
  echo 'Starting a visual regresison test between the live and test environments...' . "\n";
  $curl = curl_init();
  $curl_options = array(
    CURLOPT_URL => 'https://backtrac.io/api/project/' . $project_id . '/compare_prod_stage',
    CURLOPT_HTTPHEADER => array('x-api-key: ' . $api_key),
    CURLOPT_POST => 1,
    CURLOPT_RETURNTRANSFER => 1,
  );
  curl_setopt_array($curl, $curl_options);
  $curl_response = json_decode(curl_exec($curl));
  curl_close($curl);

  if ($curl_response->status == 'success') {
    echo ucwords($curl_response->status) . ': ' . $curl_response->result->message . "\n";
    echo "Check out the result here: " . $curl_response->result->url . "\n";
  }
  else {
    echo ucwords($curl_response->status) . ': ' . $curl_response->message . "\n";
  }
}
