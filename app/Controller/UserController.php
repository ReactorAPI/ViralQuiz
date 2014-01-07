<?php

class UserController extends AppController {

    public function beforeFilter(){
                parent::beforeFilter();
                $this->Auth->allow('askEmail');
                $this->Auth->autoRedirect = false;
    }
	
	public function askEmail() {
		if(!empty($_POST)) {
				$userid = $this->Session->read('twitter_userid');
                $user = $this->User->find('first', array(
                        'conditions' => array(
                                'User.twitter_userid' => $userid
                        )
                ));
                $this->User->id = $user['User']['id'];
                $this->User->saveField('email', $_POST['data']['User']['email']);
		}
	}

	public function waiting() {
		$userid = $this->Session->read('twitter_userid');
		$currentuser = $this->User->find('first', array(
                        'conditions' => array(
                                'User.twitter_userid' => $userid
                        )
        ));

		if($currentuser['User']['processed'] == true) {
			$this->redirect('/user/view');
		}
	}

	public function view() {
		$this->loadModel('Personality');
		$userid = $this->Session->read('twitter_userid');
		$currentuser = $this->User->find('first', array(
                        'conditions' => array(
                                'User.twitter_userid' => $userid
                        )
                ));

		if($currentuser['User']['processed'] == false) {
			$this->redirect('/user/waiting');
		}

		$result = $this->Personality->find('first', array('conditions'=>array('Personality.id'=>$currentuser['User']['personality_id'])));
		$this->set('result', $result);
	}

}
?>