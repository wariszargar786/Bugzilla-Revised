// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import "bootstrap"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "@fortawesome/fontawesome-free/js/all";

document.addEventListener("turbolinks:load", function() {


});
$(function() {
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#img_prev').removeClass("avatar-upload-image-tag");
                $('#img_prev').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#avatar-upload").change(function(){
        $('#img_prev').removeClass('hidden');
        readURL(this);
    });
});
Rails.start()
Turbolinks.start()
ActiveStorage.start()
