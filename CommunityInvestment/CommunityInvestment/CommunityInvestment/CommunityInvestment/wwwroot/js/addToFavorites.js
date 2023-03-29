function addToFavorites(missionId) {

    $.ajax({
        url: "/Home/addToFavorites?_=" + new Date().getTime(),
        type: "POST",
        data: { missionId: missionId },
        success: function (result) {
            if (result.success) {
                $('#add-fav-btn').html('<i class="bi bi-heart-fill m-2 text-danger" style="color:#757575;"></i> Remove from Favourite');
                $('#add-fav-btn').attr('onclick', 'removeFromFavorites(' + missionId + ')');

            }

        },
        error: function (xhr, status, error) {
            console.log(xhr.responseText);
        }
    });
}




