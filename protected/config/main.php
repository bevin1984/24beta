<?php
define('BETA_CONFIG_ROOT', dirname(__FILE__));
require(BETA_CONFIG_ROOT . DS . 'define.php');

try {
    $params = require(BETA_CONFIG_ROOT . DS . 'params.php');
    $defaultSetting = require(BETA_CONFIG_ROOT . DS . 'setting.php');
    $params = array_merge($defaultSetting, $params);
    $cachefile = $defaultSetting['dataPath'] . DS . 'setting.config.php';
    if (file_exists($cachefile)) {
        $customSetting = require($cachefile);
        $params = array_merge($params, $customSetting);
    }
    
}
catch (Exception $e) {
    echo $e->getMessage();
    exit(0);
}

$dbconfig = require($params['dataPath'] . DS . 'db.config.php');

return array(
    'id' => $_SERVER["HTTP_HOST"],
    'name' => $params['sitename'],
    'basePath' => BETA_CONFIG_ROOT . DS . '..',
    'charset' => 'utf-8',
    'language' => $params['language'],
    'layout' => 'main',
    'timezone' => $params['timezone'],
    'theme' => empty($params['theme']) ? null : $params['theme'],

    'import' => array(
		'application.models.*',
		'application.components.*',
        'application.extensions.*',
        'application.widgets.*',
        'application.helpers.*',
        'application.libs.*',
        'application.apis.*',
	),
        
    'modules' => array(
        'admin' => array(
            'layout' => 'main',
        ),
        'mobile' => array(
            'layout' => 'main',
        ),
        'member' => array(
            'layout' => 'main',
        ),
    ),
    'preload' => array('log'),
    'components' => array(
        'log' => array(
            'class'=>'CLogRouter',
            'routes'=>array(
                array(
                    'class'=>'CFileLogRoute',
                    'categories'=>'system.db.*',
                ),
                /* array(
                    'class'=>'CWebLogRoute',
                    'levels'=>'trace,info,error,notic',
                    'categories'=>'system.db.*',
                ), */
            ),
        ),
        'errorHandler' => array(
            'errorAction' => 'site/error',
        ),
        'user' => array(
            'class' => 'CDWebUser',
            'allowAutoLogin' => true,
            'loginUrl' => array('site/login'),
            'returnUrl' => array('site/index')
        ),
        'db' => array(
            'class' => 'CDbConnection',
			'connectionString' => sprintf('mysql:host=%s; port=%s; dbname=%s', $dbconfig['dbHost'], $dbconfig['dbPort'], $dbconfig['dbName']),
			'username' => $dbconfig['dbUser'],
		    'password' => $dbconfig['dbPassword'],
		    'charset' => 'utf8',
		    'persistent' => false,
		    'tablePrefix' => $dbconfig['tablePrefix'],
//             'enableParamLogging' => true,
//             'enableProfiling' => true,
            'attributes' => array(
                PDO::ATTR_EMULATE_PREPARES => true,
            ),
		    'schemaCacheID' => 'cache',
		    'schemaCachingDuration' => 3600 * 24,    // metadata 缓存超时时间(s)
		    'queryCacheID' => 'fcache',
		    'queryCachingDuration' => 60,
        ),
        'cache' => array(
            'serializer' => array('igbinary_serialize', 'igbinary_unserialize'),
            'class'=>'CMemCache',
            'useMemcached' => extension_loaded('memcached'),
            'servers'=>array(
                array('host'=>'localhost', 'port'=>22122, 'weight'=>100),
            ),
        ),
        'fcache' => array(
            'class' => 'CFileCache',
            'directoryLevel' => 2,
        ),
        'assetManager' => array(
            'basePath' => $params['resourceBasePath'] . 'assets',
            'baseUrl' => $params['resourceBaseUrl'] . 'assets',
        ),
        'themeManager' => array(
            'themeClass' => 'CDTheme',
            'basePath' => BETA_CONFIG_ROOT . DS . '..' . DS . '..' . DS . 'themes',
            'baseUrl' => $params['themeResourceBaseUrl'],
        ),
        'session' => array(
            'autoStart' => true,
            'cookieParams' => array(
                'lifetime' => $params['autoLoginDuration'],
            ),
        ),
        'widgetFactory'=>array(
            'enableSkin'=>true,
        ),
        'authManager' => array(
            'class' => 'CDbAuthManager',
            'assignmentTable' => '{{auth_assignment}}',
            'itemChildTable' => '{{auth_itemchild}}',
            'itemTable' => '{{auth_item}}',
        ),
        'urlManager' => array(
            'urlFormat' => $params['urlFormat'],
		    'showScriptName' => false,
            'caseSensitive' => false,
            'cacheID' => 'cache',
            'rules' => array(
                'page/<page:\d+>' => 'site/index',
                '' => 'site/index',
                'archives/<id:\d+>' => 'post/show',
                'post-<id:\d+>' => 'post/detail',
                '<_a:(login|signup|logout)>' => 'site/<_a>',
                '<_c:(category|topic)>/<id:\d+>/page/<page:\d+>' => '<_c>/posts',
                '<_c:(category|topic)>/<id:\d+>' => '<_c>/posts',
                'topics' => 'topic/list',
                'tag/<name:.+>' => 'tag/posts',
                'feed/<_a:(category|topic)>/<id:\d+>' => 'feed/<_a>',
            
                'mobile/page/<page:\d+>' => 'mobile/default/index',
                'mobile' => 'mobile/default/index',
                'mobile/archives/<id:\d+>' => 'mobile/post/show',
            
                'account' => 'member/default/index',
            ),
        ),
    ),

    'params' => $params,
);
