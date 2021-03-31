<?php
return array (
  'utf_mode' =>
  array (
    'value' => true,
    'readonly' => true,
  ),
  'cache_flags' =>
  array (
    'value' =>
    array (
      'config_options' => 3600.0,
      'site_domain' => 3600.0,
    ),
    'readonly' => false,
  ),
  'cookies' =>
  array (
    'value' =>
    array (
      'secure' => false,
      'http_only' => true,
    ),
    'readonly' => false,
  ),
  'exception_handling' =>
  array (
    'value' =>
    array (
      'debug' => false,
      'handled_errors_types' => 4437,
      'exception_errors_types' => 4437,
      'ignore_silence' => false,
      'assertion_throws_exception' => true,
      'assertion_error_type' => 256,
      'log' => NULL,
    ),
    'readonly' => false,
  ),
  'connections' =>
  array (
    'value' =>
    array (
      'default' =>
      array (
        'className' => '\\Bitrix\\Main\\DB\\MysqliConnection',
        'host' => 'mysql',
        'database' => 'sitemanager',
        'login' => 'bitrix',
        'password' => '**bitrix**',
        'options' => 2.0,
      ),
    ),
    'readonly' => true,
  ),
  'crypto' =>
  array (
    'value' =>
    array (
      'crypto_key' => '5ca632b0700c3567c2a40ce7660b58e8',
    ),
    'readonly' => true,
  ),

  'pull' => Array(
      'value' =>  array(
          'path_to_listener' => 'http://#DOMAIN#/bitrix/sub/',
          'path_to_listener_secure' => 'https://#DOMAIN#/bitrix/sub/',
          'path_to_modern_listener' => 'http://#DOMAIN#/bitrix/sub/',
          'path_to_modern_listener_secure' => 'https://#DOMAIN#/bitrix/sub/',
          'path_to_mobile_listener' => 'http://#DOMAIN#:8893/bitrix/sub/',
          'path_to_mobile_listener_secure' => 'https://#DOMAIN#:8894/bitrix/sub/',
          'path_to_websocket' => 'ws://#DOMAIN#/bitrix/subws/',
          'path_to_websocket_secure' => 'wss://#DOMAIN#/bitrix/subws/',
          'path_to_publish' => 'http://127.0.0.1:8895/bitrix/pub/',
          'nginx_version' => '3',
          'nginx_command_per_hit' => '100',
          'nginx' => 'Y',
          'nginx_headers' => 'N',
          'push' => 'Y',
          'websocket' => 'Y',
          'signature_key' => 'bVQdNsrRsulOnj9lkI0sPim292jMtrnji0zzEl5MzCBeHT7w1E5HL3aihFb6aiFJfNEIDxmcFrowS3PTLZFDxAfuNNuCN5EcFRaveaUaRZHSThtWKV7Vp5vGbz9kb3cN',
          'signature_algo' => 'sha1',
          'guest' => 'N',
      ),
  ),
);

