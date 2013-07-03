<?php

/**
 * This is the model class for table "{{post}}".
 *
 * The followings are the available columns in table '{{post}}':
 * @property integer $id
 * @property integer $post_type
 * @property integer $category_id
 * @property integer $topic_id
 * @property string $title
 * @property integer $create_time
 * @property string $create_ip
 * @property integer $score
 * @property integer $score_nums
 * @property integer $comment_nums
 * @property integer $digg_nums
 * @property integer $visit_nums
 * @property integer $favorite_nums
 * @property integer $user_id
 * @property string $user_name
 * @property string $source
 * @property string $tags
 * @property integer $state
 * @property integer $istop
 * @property integer $disable_comment
 * @property integer $recommend
 * @property integer $hottest
 * @property integer $homeshow
 * @property string $thumbnail
 * @property string $summary
 * @property string $content
 * @property integer $contributor_id
 * @property string $contributor
 * @property string $contributor_site
 * @property string $contributor_email
 * @property string $filterSummary
 * @property string $filterContent
 * @property string $createTime
 * @property string $authorName
 * @property string $contributorName
 * @property string $contributorLink
 * @property float $rating
 * @property string $sourceLink
 * @property string $url
 * @property string $absoluteUrl
 * @property string $relativeUrl
 * @property string $titleLink
 * @property string $postToolbar
 * @property string $subTitle
 * @property string $tagArray
 * @property string $tagText
 * @property string $tagLinks
 * @property string $thumbnailUrl
 * @property string $categoryLink
 * @property string $topicLink
 * @property string $summaryContainImage
 * @property string $containCode
 * @property Topic $topic
 * @property Category $category
 * @property User $user
 * @property array $comments
 * @property array$files
 */
class Post extends CActiveRecord
{
    public static function states()
    {
        return array(POST_STATE_ENABLED, POST_STATE_DISABLED, POST_STATE_REJECTED, POST_STATE_NOT_VERIFY, POST_STATE_TRASH);
    }

    public static function stateLabels($state = null)
    {
        $labels = array(
            POST_STATE_ENABLED => t('post_state_enabled', 'basic'),
            POST_STATE_DISABLED => t('post_state_disabled', 'basic'),
            POST_STATE_NOT_VERIFY => t('post_state_not_verify', 'basic'),
            POST_STATE_REJECTED => t('post_state_rejected', 'basic'),
            POST_STATE_TRASH => t('post_state_trash', 'basic'),
        );
    
        return $state === null ? $labels : $labels[$state];
    }
    
    public function getStateLabel()
    {
        return self::stateLabels($this->state);
    }
    
    public static function types()
    {
        return array(POST_TYPE_POST, POST_TYPE_ALBUM, POST_TYPE_VOTE, POST_TYPE_GOODS);
    }
    
	/**
	 * Returns the static model of the specified AR class.
	 * @return Post the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return TABLE_POST;
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
	        array('title, summary, content', 'required'),
	        array('post_type, category_id, topic_id, score_nums, comment_nums, digg_nums, visit_nums, favorite_nums, user_id, create_time, state, istop, homeshow, disable_comment, contributor_id, recommend, hottest', 'numerical', 'integerOnly'=>true),
			array('thumbnail, source, title, tags, contributor_site, contributor_email', 'length', 'max'=>250),
			array('create_ip', 'length', 'max'=>15),
			array('user_name, contributor', 'length', 'max'=>50),
	        array('contributor_site', 'url'),
	        array('contributor_email', 'email'),
    		array('state', 'in', 'range'=>self::states()),
    		array('post_type', 'in', 'range'=>self::types()),
			array('summary, content', 'safe'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		return array(
	        'category'=>array(self::BELONGS_TO, 'Category', 'category_id'),
	        'topic'=>array(self::BELONGS_TO, 'Topic', 'topic_id'),
		    'uploadCount' => array(self::STAT, 'Upload', 'post_id'),
		    'commentCount' => array(self::STAT, 'Comment', 'post_id'),
		    'picture' => array(self::HAS_MANY, 'Upload', 'post_id',
		        'condition' => 'file_type = :filetype',
		        'params' => array(':filetype' => UPLOAD_TYPE_PICTURE),
		        'order' => 'id asc',
		    ),
		    'pictureCount' => array(self::STAT, 'Upload', 'post_id',
		        'condition' => 'file_type = :filetype',
		        'params' => array(':filetype' => UPLOAD_TYPE_PICTURE),
		    ),
		    'audio' => array(self::HAS_MANY, 'Upload', 'post_id',
		        'condition' => 'file_type = :filetype',
		        'params' => array(':filetype' => UPLOAD_TYPE_AUDIO),
		        'order' => 'id asc',
		    ),
		    'video' => array(self::HAS_MANY, 'Upload', 'post_id',
		        'condition' => 'file_type = :filetype',
		        'params' => array(':filetype' => UPLOAD_TYPE_VIDEO),
		        'order' => 'id asc',
		    ),
		    'downfile' => array(self::HAS_MANY, 'Upload', 'post_id',
		        'condition' => 'file_type = :filetype',
		        'params' => array(':filetype' => UPLOAD_TYPE_FILE),
		        'order' => 'id asc',
		    ),
		    'user' => array(self::BELONGS_TO, 'User', 'user_id'),
		    'comments' => array(self::HAS_MANY, 'Comment', 'post_id'),
		    'files' => array(self::HAS_MANY, 'Upload', 'post_id'),
		    
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
            'post_type' => t('post_type', 'model'),
			'category_id' => t('post_category', 'model'),
			'topic_id' => t('post_topic', 'model'),
			'title' => t('post_title', 'model'),
			'create_time' => t('create_time', 'basic'),
			'create_ip' => t('create_ip', 'basic'),
			'score' => t('post_score', 'model'),
			'score_nums' => t('post_score_nums', 'model'),
			'comment_nums' => t('post_comment_nums', 'model'),
			'digg_nums' => t('post_digg_nums', 'model'),
			'visit_nums' => t('post_visit_nums', 'model'),
			'favorite_nums' => t('post_favorite_nums', 'model'),
			'user_id' => t('post_user_id', 'model'),
			'user_name' => t('post_user_name', 'model'),
	        'source' => t('post_source', 'model'),
			'tags' => t('post_tags', 'model'),
			'state' => t('post_state', 'model'),
			'istop' => t('post_istop', 'model'),
		    'disable_comment' => t('post_disable_comment', 'model'),
	        'recommend' => t('post_recommend', 'model'),
	        'hottest' => t('post_hottest', 'model'),
	        'homeshow' => t('post_homeshow', 'model'),
			'thumbnail' => t('post_thumbnail', 'model'),
			'summary' => t('post_summary', 'model'),
			'content' => t('post_content', 'model'),
		    'contributor_id' => t('post_contributor_id', 'model'),
		    'contributor' => t('post_contributor', 'model'),
		    'contributor_site' => t('post_contributor_site', 'model'),
		    'contributor_email' => t('post_contributor_email', 'model'),
		);
	}
	
	public function scopes()
	{
	    return array(
            'homeshow' => array(
                'condition' => 't.homeshow = ' . BETA_YES,
            ),
            'rejected' => array(
                'condition' => 't.state = ' . POST_STATE_REJECTED,
            ),
            'published' => array(
                'condition' => 't.state = ' . POST_STATE_ENABLED,
            ),
            'hottest' => array(
                'condition' => 't.hottest = ' . BETA_YES,
                'order' => 't.create_time desc',
            ),
            'recommend' => array(
                'condition' => 't.recommend = ' . BETA_YES,
                'order' => 't.create_time desc',
            ),
            'recently' => array(
                'condition' => 't.state = ' . POST_STATE_ENABLED,
                'order' => 't.create_time desc',
                'limit' => 10,
            ),
	    );
	}
	
	public function getFilterSummary()
	{
	    $tags = param('summaryHtmlTags');
	    $html = strip_tags($this->summary, $tags);
	    if (stripos(strtolower($tags), 'img') !== false)
	        $html = self::processImgTag($html);
	    
	    return $html;
	}
	public function getFilterContent()
	{
	    $html = $this->content;
	    // @todo filter content
// 	    $html = self::processImgTag($html);
	    return $html;
	}
	
	public function getCreateTime($format = null)
	{
	    if  (null === $format)
	        $format = param('formatShortDateTime');
	
	    return date($format, $this->create_time);
	}
	
	public function getShortDate()
	{
	    $format = param('formatShortDate');
	    
	    return $this->getCreateTime($format);
	}
	
	public function getShortTime()
	{
	    $format = param('formatShortTime');
	    
	    return $this->getCreateTime($format);
	}
	
	public function getAuthorName()
	{
	    static $name = null;
	
	    if (null !== $name) return $name;
	
	    if ($this->user_name)
	        $name = $this->user_name;
	    elseif ($this->user_id)
    	    $name = $this->user->name;
	    else
	        $name = t('guest_name');
	
	    return $name;
	}
	
	public function getContributorName()
	{
	    return (empty($this->contributor)) ? t('guest_name') : $this->contributor;
	}
	
	public function getContributorLink()
	{
	    $name = $this->getContributorName();
	    return $this->contributor_site ? l($name, $this->contributor_site, array('target'=>'_blank')) : $name;
	}
	
	public function getRating()
	{
	    $nums = $this->score_nums ? $this->score_nums : 1;
	    return sprintf('%.1f', $this->score / $nums);
	}
	
	public function getSourceLink()
	{
	    if (empty($this->source)) return '';
	    
	    $textLen = 50;
	    $text = mb_strimwidth($this->source, 0, $textLen, '...', app()->charset);
	    
	    $pos = stripos($this->source, 'http://');
	    if ($pos === false)
	        $source = $text;
	    elseif ($pos === 0)
	        $source = l($text, $this->source, array('target'=>'_blank', 'class'=>'post-source'));
	    else
	        $source = '';
	    
	    return $source;
	}
	
	public function getUrl($absolute = true)
	{
	    return $absolute ? aurl('post/show', array('id'=>$this->id)) : url('post/show', array('id'=>$this->id));
	}
	
	public function getAbsoluteUrl()
	{
	    return $this->getUrl(true);
	}
	
	public function getRelativeUrl()
	{
	    return $this->getUrl(false);
	}
	
	public function getTitleLink($len = 0, $target = '_blank')
	{
	    $len = (int)$len;
	    if ($this->istop == BETA_YES)
	        $this->title = '[' . t('post_istop', 'model') . ']' . $this->title;
	    $title = ($len === 0) ? $this->title : $this->getSubTitle($len);
	    if ($this->istop == BETA_YES)
	        $title = '<strong>' . $title . '</strong>';
	    return l($title, $this->getUrl(), array('class'=>'post-title', 'target'=>$target, 'title'=>$this->title));
	}
	
	public function getPostToolbar()
	{
	    // @todo 此处authorName最终应该为authorLink
	    return array('{comment_nums}'=>$this->comment_nums, '{score_nums}'=>$this->score_nums, '{visit}'=>$this->visit_nums, '{digg}'=>$this->digg_nums);
	}
	
	public function getSubTitle($len = 40)
	{
	    return mb_strimwidth($this->title, 0, $len, '...', app()->charset);
	}
	
	public function getSubSummary($len)
	{
	    $len = (int)$len;
	    $text = trim(strip_tags($this->summary));
	    if ($len === 0)
	        return $text;
	    else
	        return mb_strimwidth($text, 0, $len, '...', app()->charset);
	}
	
	/**
	 * 获取标签的数组形式
	 * @return array
	 */
	public function getTagArray()
	{
	    return Tag::filterTagsArray($this->tags);
	}
	
	public function getTagText($operator = ',')
	{
	    $tagsArray = $this->getTagArray();
	     
	    return (empty($tagsArray)) ? '' : join($operator, $tagsArray);
	}
	
	public function getTagLinks($operator = ',', $target = '_blank', $class='beta-tag')
	{
	    $tags = $this->getTagArray();
	    if (empty($tags)) return '';
	
	    foreach ($tags as $tag)
	        $data[] = l($tag, aurl('tag/posts', array('name'=>$tag)), array('target'=>$target, 'class'=>$class));
	    
	    return join($operator, $data);
	}

	public function getThumbnailUrl()
	{
	    $url = $this->thumbnail;
	    if (empty($url)) {
	        // @todo 此处读取文章中第一个图片作为缩略图。
	    }
	    
	    if (empty($url)) return '';

	    $pos = stripos($this->thumbnail, 'http://');
        if ($pos === false)
            $url = fbu($this->thumbnail);
        elseif ($pos === 0)
            $url = $this->thumbnail;
	    else
	        $url = '';
	    
	    return $url;
	}

	public function getCategoryLink($target = '_blank')
	{
	    if ($this->category)
	        return $this->category->getPostsLink($target);
	    else
	        return '';
	}
	
	public function getTopicLink($target = '_blank')
	{
	    $html = '';
	    if ($this->topic_id > 0 && $this->topic)
	        $html = $this->topic->getPostsLink($target);
	    
	    return $html;
	}
	
	public function getShowExtraInfo()
	{
	    return t('post_show_extra', 'main', array('{author}'=>$this->authorName, '{time}'=>$this->createTime, '{visit}'=>$this->visit_nums, '{digg}'=>$this->digg_nums));
	}

	public function getSummaryContainImage()
	{
	    $pos = stripos($this->getFilterSummary(), '<img');
	    return $pos !== false;
	}
	
	public function getTopicIconHtml()
	{
	    $html = '';
	    if ($this->topic_id > 0 && (bool)param('post_list_show_topic_icon') === true && $this->topic !== null && !$this->getSummaryContainImage())
	        $html = $this->topic->getIconPostsLink();
	    
	    return $html;
	}

	public function getContainCode()
	{
	    $pos = stripos($this->getFilterContent(), 'prettyprint');
	    return $pos !== false;
	}
	
	public function trash()
	{
	    if ($this->getIsNewRecord())
	        throw new CException('this is a new record');
	    else {
    	    $this->state = POST_STATE_TRASH;
    	    $result = $this->save(true, array('state'));
    	    return $result;
	    }
	}
	
	/**
	 * 处理内容中的img标签
	 * @param string $html html内容
	 * @return string
	 */
	public static function processImgTag($html)
	{
	    $html = str_replace('/>', ' />', $html);
	    
	    $pattern = '/<img.*?src="?(.+?)["\s]{1}?.*?>/is';
	    if (param('enable_lazyload_img'))
            $img = '<img src="' . sbu('images/grey.gif') . '" data-original="${1}" class="lazy" />';
	    else
            $img = '<img src="${1}" class="lazy" />';
        $html = preg_replace($pattern, $img, $html);
        return $html;
	}
	
	public function getDiggButtonHtml()
	{
	    $html = '<a id="beta-digg-button" class="beta-digg-button" href="javascript:void(0);" data-url="%s" rel="nofollow" title="%s" data-id="%d">';
	    $html .= '<span class="digg-plus">%s</span><span class="digg-count">%d</span></a>';
	    $html = sprintf($html, aurl('post/digg'), 'Like', (int)$this->id, t('like_post'), (int)$this->digg_nums);
	    return $html;
	}
	
	public function getFavoriteButtonHtml()
	{
	    $html = '<a id="beta-favorite-button" class="beta-digg-button" href="javascript:void(0);" data-url="%s" rel="nofollow" title="%s" data-id="%d">';
	    $html .= '<span class="digg-plus">%s</span><span class="favorite-count">%d</span></a>';
	    $html = sprintf($html, aurl('post/like'), 'Add to favorite', (int)$this->id, t('favorite_post'), (int)$this->favorite_nums);
	    return $html;
	}
	
	protected function beforeSave()
	{
	    if ($this->getIsNewRecord()) {
	        $this->title = strip_tags($this->title);
	        $this->create_time = $_SERVER['REQUEST_TIME'];
	        $this->create_ip = request()->getUserHostAddress();
	        $this->source = strip_tags(trim($this->source));
	        $visitNumsMin = (int)param('visit_nums_init_min');
	        $visitNumsMax = (int)param('visit_nums_init_max');
	        if ($this->visit_nums == 0 && $visitNumsMax > 0 && $visitNumsMax > $visitNumsMin)
	            $this->visit_nums = mt_rand($visitNumsMin, $visitNumsMax);
	    }
	    if ($this->tags) {
    	    $tags = join(',', Tag::filterTagsArray($this->tags));
    	    $this->tags = $tags;
	    }
	    return true;
	}
	
	protected function afterSave()
	{
	    if ($this->getIsNewRecord()) {
	        $counters = array('post_nums' => 1);
	        Category::model()->updateCounters($counters, 'id = :cid', array(':cid'=>$this->category_id));
	        Topic::model()->updateCounters($counters, 'id = :tid', array(':tid'=>$this->topic_id));
	    }
	    Tag::savePostTags($this->id, $this->tags);
	}
	
	protected function afterDelete()
	{
	    $counters = array('post_nums' => -1);
	    Category::model()->updateCounters($counters, 'id = :cid', array(':cid'=>$this->category_id));
	    Topic::model()->updateCounters($counters, 'id = :tid', array(':tid'=>$this->topic_id));
	     
	    foreach ($this->comments as $c) $c->delete();
	     
	    app()->getDb()->createCommand()->delete(TABLE_POST_TAG, 'post_id = :pid', array(':pid'=>$this->id));
	    app()->getDb()->createCommand()->delete(TABLE_SPECIAL_POST, 'post_id = :pid', array(':pid'=>$this->id));
	    app()->getDb()->createCommand()->delete(TABLE_POST_FAVORITE, 'post_id = :postid', array(':postid' => $this->id));
	     
	    foreach ($this->files as $file) $file->delete();
	}
	
	protected function afterFind()
	{
	    if (empty($this->summary)) {
	        $content = strip_tags($this->content, param('summaryHtmlTags'));
	        $this->summary = mb_strimwidth($content, 0, param('subSummaryLen'), '...', app()->charset);
	    }
	    else
	        $this->summary = strip_tags($this->summary, param('summaryHtmlTags'));
	}

}





