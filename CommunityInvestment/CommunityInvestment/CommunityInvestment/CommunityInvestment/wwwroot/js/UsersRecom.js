$(document).ready(function () {
    $("#Recommend").on("click", function () {
        var selctedUserId = $('.user-check:checked').map(function () {
            return $(this).data('user-id');
        }).get().join(',');

        var missionId = $(this).data("mission-id");
        console.log(selctedUserId);
      
        $.ajax({
            url: "/Home/RecommendUsers",
            type: "POST",
            data: { userId: JSON.stringify(selctedUserId), missionId: missionId },
            success: function (response) {
                console.log(response);
            },
            error: function (xhr, status, error) {
                alert('Error: ' + error);
            }
        });
    });
    
});