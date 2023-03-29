function removeFromFavorites(missionId) {

    $.ajax({
        url: "/Home/RemoveFromFavorites?_=" + new Date().getTime(),
        type: "POST",
        data: { missionId: missionId },
        success: function (result) {
            if (result.success) {
                $('#remove-fav-btn').html('<i class="bi bi-heart m-2" style="color:# 757575;"></i> Add to Favourite');
                $('#remove-fav-btn').attr('onclick', 'addToFavorites(' + missionId + ')');

            }

        },
        error: function (xhr, status, error) {
            console.log(xhr.responseText);
        }

    });
}