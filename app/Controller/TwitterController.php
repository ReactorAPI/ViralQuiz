<?php

App::import('Vendor', 'OAuth/OAuthClient');

class TwitterController extends AppController {

	public $uses = array("Auth", "User");

    public function beforeFilter(){
                parent::beforeFilter();
                $this->Auth->allow('index','callback', 'createClient');
                $this->Auth->autoRedirect = false;
    }

	public function index($key = false) {
                $client = $this->createClient();
                $requestToken = $client->getRequestToken('https://api.twitter.com/oauth/request_token', 'http://' . $_SERVER['HTTP_HOST'] . '/twitter/callback');

                if ($requestToken) {
                        $this->Session->write('twitter_request_token', $requestToken);
                        $this->redirect('https://api.twitter.com/oauth/authenticate?oauth_token=' . $requestToken->key . '');
                } else {
                        // an error occured when obtaining a request token
                }
    }

    public function callback() {

                $requestToken = $this->Session->read('twitter_request_token');
                $client = $this->createClient();
                $accessToken = $client->getAccessToken('https://api.twitter.com/oauth/access_token', $requestToken);

                $user_data = $client->get($accessToken->key, $accessToken->secret, 'https://api.twitter.com/1.1/account/verify_credentials.json');
                $user_data = json_decode($user_data->body, true);

                $user_cover = $client->get($accessToken->key, $accessToken->secret, 'https://api.twitter.com/1.1/users/profile_banner.json', array('user_id' => $user_data['id']));
                $user_cover = json_decode($user_cover->body, true);

                $this->Session->write('twitter_userid', $user_data['id']);

                $user_data_json = json_encode($user_data);

                $user = $this->User->find('first', array(
                        'conditions' => array(
                                'User.twitter_userid' => $user_data['id']
                        )
                ));

                if ( count($user) > 0 ) {

                        $this->User->id = $user['User']['id'];
                        if ( $user['User']['twitter_oauth'] != $accessToken->key ) {
                                if(!$this->User->saveField('twitter_oauth', $accessToken->key))
                                	$this->Session->setFlash(__('<strong>Ocurri&oacute; un error inesperado.</strong>'));
                        }
                        if ( $user['User']['twitter_oauth_secret'] != $accessToken->secret ) {
                                if(!$this->User->saveField('twitter_oauth_secret', $accessToken->secret))
                                	$this->Session->setFlash(__('<strong>Ocurri&oacute; un error inesperado.</strong>'));
                        }
                        if ( $user['User']['profile_picture'] != str_replace("_normal", "", $user_data['profile_image_url']) ) {
                                if(!$this->User->saveField('profile_picture', str_replace("_normal", "", $user_data['profile_image_url'])))
                                	$this->Session->setFlash(__('<strong>Ocurri&oacute; un error inesperado.</strong>'));
                        }
                        if ( $user['User']['json_data'] != $user_data_json ) {
                        		if(!$this->User->saveField('json_data', $user_data_json))
                        			$this->Session->setFlash(__('<strong>Ocurri&oacute; un error inesperado.</strong>'));
                        }
                        if ( $user['User']['name'] != $user_data['name'] ) {
                        		if(!$this->User->saveField('name', $user_data['name']))
                        			$this->Session->setFlash(__('<strong>Ocurri&oacute; un error inesperado.</strong>'));
                        }
                        if ( $user['User']['username'] != $user_data['screen_name'] ) {
                        		if(!$this->User->saveField('username', $user_data['screen_name']))
                        			$this->Session->setFlash(__('<strong>Ocurri&oacute; un error inesperado.</strong>'));
                        }

                        $this->Auth->login($user['User']['id']);
                } else {
                        $this->User->create();
                        $data = array(
                                'User' => array(
                                        'username' => $user_data['screen_name'],
                                        'name' => $user_data['name'],
                                        'profile_picture' => str_replace("_normal", "", $user_data['profile_image_url']),
                                        'twitter_userid' => $user_data['id'],
                                        'json_data' => $user_data_json,
                                        'twitter_oauth' => $accessToken->key,
                                        'twitter_oauth_secret' => $accessToken->secret
                                )
                        );
                        if (!$this->User->save($data) ) {
                        	$this->Session->setFlash(__('<strong>Ocurri&oacute; un error inesperado.</strong>.'));
                        	$this->redirect('/');
                        }
                        $this->Auth->login($this->User->id);
                }
                $this->redirect('/user/askEmail');
        }

    public function testPost(){
                if ( $this->currentUser['twitter_userid'] != 0 ) {
                        $client = new OAuthClient('zGVCwqO3fjXHBCyzi1GfkA', 'iCqswFYVuS7MZLhWdk0bS8B0db2pb3CHQHDUfB4');
                        $client->post($this->currentUser['twitter_oauth'], $this->currentUser['twitter_oauth_secret'], 'https://api.twitter.com/1.1/statuses/update.json', array('status' => 'Sent from Reactor.'));
                } else {
                        $this->Session->setFlash('No Twitter.');
                        $this->redirect('/');
                }
    }

    private function createClient() {
                return new OAuthClient('zGVCwqO3fjXHBCyzi1GfkA', 'iCqswFYVuS7MZLhWdk0bS8B0db2pb3CHQHDUfB4');
    }

}

?>