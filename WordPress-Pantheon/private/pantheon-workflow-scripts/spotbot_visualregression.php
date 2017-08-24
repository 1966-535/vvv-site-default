<?php


// Provide the API Key provided by Spotbot.qa
$api_key = '4803f401-be21-4d44-882a-dca3ac713035';

// Provide the Project URL for the project on Spotbot.qa
$project_url = 'https://live-otestsite.pantheonsite.io';

// If we are deploying to test, run a visual regression test
// between the production environment and the testing environment.
if (defined('PANTHEON_ENVIRONMENT') && (PANTHEON_ENVIRONMENT == 'test')) {
  echo 'Starting a visual regresison test between the live and test environments...' . "\n";
  $curl = curl_init();
  $curl_options = array(
    CURLOPT_URL => 'https://spotbot.qa/api/scans',
    CURLOPT_HTTPHEADER => array('Authorization: ' . $api_key),
    CURLOPT_POST => 1,
    CURLOPT_RETURNTRANSFER => 1,
    CURLOPT_POST => 1,
    CURLOPT_POSTFIELDS => 'pageUrl=' . urlencode($project_url),
  );
  curl_setopt_array($curl, $curl_options);
  $curl_response = json_decode(curl_exec($curl));
  curl_close($curl);

  if ($curl_response->status == 'ok') {
    echo ucwords($curl_response->status) . "\n";
    echo "Check out the result here: " . $curl_response->result[0]->url . "\n";
  }
  else {
    echo ucwords($curl_response->status) . ': ' . $curl_response->error->message . "\n";
  }
}
