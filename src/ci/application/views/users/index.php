<h2><?php echo $title; ?></h2>

<?php foreach ($users as $user): ?>

        <h3><?php echo $user['id']; ?></h3>
        <div class="main">
                <?php echo $user['name']; ?>
        </div>
        <p><a href="<?php echo site_url('users/'.$user['id']); ?>">View user</a></p>

<?php endforeach; ?>