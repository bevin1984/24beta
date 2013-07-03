<h2 class="beta-block-title"><?php echo $blockTitle;?></h2>
<?php foreach ((array)$posts as $model):?>
<dl class="beta-post-item beta-radius3px">
    <dt><?php echo $model->titleLink;?></dt>
    <dd class="beta-post-extra"><span>
        <?php echo t('post_author_time', 'main', array('{author}'=>$model->authorName, '{time}'=>$model->createTime));?>&nbsp;&nbsp;&nbsp;&nbsp;
    </span></dd>
    <dd class="beta-post-summary">
        <?php if ($model->contributor):?><div class="beta-thank"><?php echo t('thanks_contribute', 'main', array('{contributor}'=>$model->contributorLink));?></div><?php endif;?>
        <div class="beta-post-content"><?php echo $model->topicIconHtml;?><?php echo $model->filterSummary;?></div>
    </dd>
    <dd class="beta-post-toolbar">
        <?php echo l(t('view_detail'), $model->url, array('target'=>'_blank'));?>
        <?php echo t('post_toolbar_text', 'main', $model->postToolbar);?>
    </dd>
</dl>
<?php endforeach;?>
<?php if ($pages->pageCount > 1):?>
<div class="pagination"><?php $this->widget('CLinkPager', array('pages'=>$pages));?></div>
<?php endif;?>

<?php
cs()->registerScriptFile(sbu('libs/jquery.lazyload.min.js'), CClientScript::POS_END);
if (param('enable_lazyload_img'))
    cs()->registerScript('beta-lazyload', "Beta24.imageLazyLoad($('img.lazy'));", CClientScript::POS_END);
?>