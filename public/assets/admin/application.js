(function() {



}).call(this);
(function() {



}).call(this);
(function() {

  $(document).ready(function() {
    $('.material_thumb').on({
      mouseover: function() {
        this.large_image = $(this).data('large_image');
        return $('#large_image').attr({
          src: this.large_image
        });
      }
    });
    $('.removeImg').on({
      click: function() {
        var _this = this;
        this.image_id = $(this).data('image_id');
        this.url = "/admin/images/" + this.image_id + ".json";
        console.log("about to remove image_id " + this.image_id + " using @url: " + this.url);
        return $.ajax({
          url: this.url,
          dataType: 'json',
          type: 'DELETE',
          data: {
            material_id: this.material_id,
            image_id: this.image_id
          },
          success: function(data) {
            $(_this).parent().fadeOut(555);
            return alert('Image Removed.');
          },
          error: function(data) {
            alert('Problem removing image.');
            return console.log(data.statusText);
          }
        });
      }
    });
    $('.default_image_id').on({
      change: function() {
        var _this = this;
        this.material_id = $(this).data('material_id');
        this.default_image_id = $(this).data('default_image_id');
        this.image_id = $(this).data('image_id');
        console.log("test mat_id: " + this.material_id + " def_image_id: " + this.default_image_id);
        this.url = "/admin/materials/" + this.material_id + "/update_default_image.json";
        return $.ajax({
          url: this.url,
          dataType: 'json',
          type: 'PUT',
          data: {
            material_id: this.material_id,
            default_image_id: this.image_id
          },
          success: function(data) {
            return alert('Default image saved.');
          },
          error: function(data) {
            alert('Problem saving default image.');
            return console.log(data.statusText);
          }
        });
      }
    });
    return $('.finishesImg').on({
      change: function() {
        var _this = this;
        this.image_id = $(this).data('image_id');
        this.finish_id = $("option:selected", this).val();
        this.url = "/admin/images/" + this.image_id + "/update_image_finish_id.json";
        console.log("test @image_id: " + this.image_id + " finish_id: " + this.finish_id + " url: " + this.url);
        return $.ajax({
          url: this.url,
          dataType: 'json',
          type: 'PUT',
          data: {
            image_id: this.image_id,
            finish_id: this.finish_id
          },
          success: function(data) {
            alert('Saved Image Finish');
            return console.log('saved image finish');
          },
          error: function(data) {
            alert('Problem Saving Image Finish.');
            return console.log(data.statusText);
          }
        });
      }
    });
  });

}).call(this);
