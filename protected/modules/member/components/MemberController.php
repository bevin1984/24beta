<?php
/**
 * Controller is the customized base controller class.
 * All controller classes for this application should extend from this base class.
 *
 * @property integer $userID
 * @property string $username
 * @property string $nickname
 * @property MemberUser $user
 * @property UserProfile $profile
 */
class MemberController extends Controller
{
    public $title;
    public $menu;
    
	public function setSiteTitle($text)
	{
	    $this->pageTitle = $text . '_' . app()->name;
	}

	/**
	 * 获取当前登录用户模型
	 * @return MemberUser 如果找不到当前登录用户，则返回null
	 */
    public function getUser()
    {
        $user = MemberUser::model()->findByPk($this->getUserID());
        if ($user === null)
            throw new CHttpException(500, '未找到用户');
        
        return $user;
    }
}