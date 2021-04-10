// Validation for Profile Picture file extention
function ProfilePictureValidation() {
    var fileInput = document.getElementById('profile-picture');
    var filepath = fileInput.value;
    var allowedextensions = /(\.jpg|\.jpeg|\.JPEG|\.png|\.gif)$/i;

    if (!allowedextensions.exec(filepath)) {
        fileInput.value = '';
        document.getElementById('profile-picture-error').innerHTML = "Image should be .jpg , .jpeg or .png file only";
        document.getElementById('profile-picture').focus();
        return false;
    }
    else {
        document.getElementById('profile-picture-error').innerHTML = "";
    }
}

// Validation for Note Display Picture file extention
function picturevalidation() {
    var fileInput = document.getElementById('display-picture');
    var filepath = fileInput.value;
    var allowedextensions = /(\.jpg|\.jpeg|\.JPEG|\.png|\.gif)$/i;

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