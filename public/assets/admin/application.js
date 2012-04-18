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
    $('.default_image_id').on({
      change: function() {
        this.material_id = $(this).data('material_id');
        this.url = "/admin/materials/" + this.material_id + "/update_default_image.json";
        this.default_image_id = $(this).data('default_image_id');
        this.image_id = $(this).data('image_id');
        this.thumb_image = $("#material_thumb_" + this.image_id);
        this.new_large_image_path = this.thumb_image.data('large_image');
        $('#large_image').attr({
          src: this.new_large_image_path
        });
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
            return log(data.statusText);
          }
        });
      }
    });
    $('.finishesImg').on({
      change: function() {
        this.image_id = $(this).data('image_id');
        this.finish_id = $("option:selected", this).val();
        this.url = "/admin/images/" + this.image_id + "/update_image_finish_id.json";
        log("test @image_id: " + this.image_id + " finish_id: " + this.finish_id + " url: " + this.url);
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
            return log('saved image finish');
          },
          error: function(data) {
            alert('Problem Saving Image Finish.');
            return log(data.statusText);
          }
        });
      }
    });
    return $('.removeImg').on({
      click: function() {
        var _this = this;
        this.image_id = $(this).data('image_id');
        this.url = "/admin/images/" + this.image_id + ".json";
        return $.ajax({
          url: this.url,
          dataType: 'json',
          type: 'DELETE',
          data: {
            material_id: this.material_id,
            image_id: this.image_id
          },
          success: function(data) {
            $(_this).parent().fadeOut(2999);
            return alert('Image Removed.');
          },
          error: function(data) {
            alert('Problem removing image.');
            return log(data.statusText);
          }
        });
      }
    });
  });

}).call(this);
