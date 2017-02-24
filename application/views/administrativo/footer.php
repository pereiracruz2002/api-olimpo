      </div>
    </div>
  </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="<?php echo base_url() ?>administrativo-assets/js/bootstrap.min.js"></script>
    <script src="<?php echo base_url() ?>administrativo-assets/fancybox/jquery.fancybox.pack.js"></script>
    <script src="<?php echo base_url() ?>administrativo-assets/js/utility.js"></script>
    <?php if (file_exists(FCPATH.'administrativo-assets/js/'.$this->uri->segment(2).'.js')): ?>
    <script src="<?php echo base_url() ?>administrativo-assets/js/<?php echo $this->uri->segment(2) ?>.js"></script>
    <?php endif; ?>
  </body>
</html>

