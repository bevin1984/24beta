<?php $this->widget('BetaHottestPosts');?>
<div class="beta-content">
    <?php $this->renderPartial('/post/_home_list', array('posts'=>$posts, 'pages'=>$pages));?>
</div>
<div class="beta-sidebar">
    <?php $this->widget('BetaAdvert', array('solt'=>'home_sidebar_ad_01'));?>
    <?php $this->widget('BetaCommentTopPosts', array('allowEmpty'=>true, 'days'=>30));?>
    <?php $this->widget('BetaVisitTopPosts', array('allowEmpty'=>true, 'days'=>30));?>
    <?php $this->widget('BetaAdvert', array('solt'=>'home_sidebar_ad_02'));?>
    <!-- editor recommend posts start -->
    <?php if ($recommend):?>
    <div class="beta-block beta-radius3px beta-recommend-posts">
        <h2><?php echo t('recommend_posts');?></h2>
        <?php foreach($recommend as $index => $post):?>
        <dl class="row<?php echo $index%2;?>">
            <dt><?php echo $post->titleLink;?></dt>
            <dd><?php echo $post->getSubSummary(85);?></dd>
        </dl>
        <?php endforeach;?>
    </div>
    <?php endif;?>
    <!-- editor recommend posts end -->
    <?php $this->widget('BetaAdvert', array('solt'=>'home_sidebar_ad_03'));?>
    <!-- recommend comments start -->
    <?php if ($comments):?>
    <div class="beta-block beta-radius3px beta-recommend-comments">
        <h2><?php echo t('recommend_comments');?></h2>
        <?php foreach($comments as $index => $comment):?>
        <dl class="row<?php echo $index%2;?>">
            <dd><?php echo $comment->filterContent;?></dd>
            <dt><?php echo $comment->post->titleLink;?></dt>
        </dl>
        <?php endforeach;?>
    </div>
    <?php endif;?>
    <!-- recommend comments end -->
    <!-- friend links start -->
    <?php $this->widget('BetaLinks');?>
    <!-- friend links end -->
</div>
<div class="clear"></div>

