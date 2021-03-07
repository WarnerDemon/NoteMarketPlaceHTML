$(".toggle-password").click(function() {

    $(this).toggleClass("fa-eye fa-eye-slash");
    var input = $($(this).attr("toggle"));
    if (input.attr("type") == "password") {
      input.attr("type", "text");
    } else {
      input.attr("type", "password");
    }
    
});


var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var panel = this.nextElementSibling;
    if (panel.style.maxHeight) {
      panel.style.maxHeight = null;
    } else {
      panel.style.maxHeight = panel.scrollHeight + "px";
    } 
  });
}

// Disable input for free
$('input:radio').click(function () {
    $("#sell-price").prop("disabled", true);
    if ($(this).hasClass('enable_tb')) {
        $("#sell-price").prop("disabled", false);
    }
});

// Validation for file extention
function picturevalidation() {
    var fileInput = document.getElementById('display-picture');
    var filepath = fileInput.value;
    var allowedextensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;

    if (!allowedextensions.exec(filepath)) {
        fileInput.value = '';
        document.getElementById('uploadpicture-error').innerHTML = "Image should be .jpg , .jpeg or .png file only";
        document.getElementById('display-picture').focus();
        return false;
    }
    else {
        document.getElementById('uploadpicture-error').innerHTML = "";
    }
}

function notesvalidation() {
    var fileInput = document.getElementById('upload-notes');
    var filepath = fileInput.value;
    var allowedextensions = /(\.pdf)$/i;

    if (!allowedextensions.exec(filepath)) {
        fileInput.value = '';
        document.getElementById('uploadnotes-error').innerHTML = "Notes should be .pdf file only";
        document.getElementById('upload-notes').focus();
        return false;
    }
    else {
        document.getElementById('uploadnotes-error').innerHTML = "";
    }
}

// File Required for Paid
$(':radio[name=flexRadioDefault]').change(function () {
    if ($(this).val() == 'Paid') {

        document.getElementById('attach-for-paid').innerHTML = "Upload Preview Notes"
    }
    else {

        document.getElementById('attach-for-paid').innerHTML = ""
    }
});
