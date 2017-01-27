<html>
<head>
   <meta charset="utf-8" />
</head>
<body>

<h2><?php echo $title; ?></h2>

<?php echo validation_errors(); ?>

<?php echo form_open('news/create'); ?>

    <label for="title">Title</label>
    <input type="input" name="title" value="<?php echo set_value('title'); ?>"/><br />

    <label for="content">Text</label>
    <textarea name="content"><?php echo set_value('content'); ?></textarea><br />

    <input type="submit" name="submit" value="Create news item" />

</form>

</body>
</html>
