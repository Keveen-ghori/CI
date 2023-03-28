
$(document).ready(function () {
    
    $('.country-item').on('change', function () {
        var selectedCountryIds = $('.country-item:checked').map(function () {
            return $(this).data('country-id');
        }).get().join(',');

        if (selectedCountryIds !== null) {
            $.ajax({
                type: 'GET',
                url: 'Home/Filter',
                data: { countryId: selectedCountryIds },
                success: function (data) {
                    var cityList = $('#cityListFilter');
                    cityList.empty();

                    $.each(data, function (i, city) {
                        var checkBoxId = "cityFilter" + city.value;
                        var liId = "li" + city.text;
                        var li = $('<li/>').attr('id', liId);
                        var div = $('<div/>').addClass('form-check dropdown-item px-4');
                        var input = $('<input/>').addClass('form-check-input mx-auto city-item cityListClass')
                            .attr('type', 'checkbox')
                            .attr('data-city-id', city.value)
                            .attr('value', city.Value);
                        var label = $('<label/>').addClass('form-check-label ps-2')
                            .attr('for', city.text)
                            .text(city.text)

                        div.append(input);
                        div.append(label);
                        li.append(div);
                        cityList.append(li);
                    });
                },
                error: function (xhr, status, error) {
                    alert('Error: ' + error);
                }
            });
        }

    });

    $(document).on('click', '.label-item', function () {
        var dataType = $(this).data('city-id') ? 'city' : $(this).data('skill-id') ? 'skill' : $(this).data('theme-id') ? 'theme' : null;
        var dataId = $(this).data(dataType + '-id');

        $('#' + dataType + 'ListFilter input[data-' + dataType + '-id="' + dataId + '"]').prop('checked', false);
        $(this).remove();
        filterData();

    });

    $(document).on('click', '.cancel-icon', function (e) {

        var id = $(this).data('city-id') || $(this).data('skill-id') || $(this).data('theme-id');
        $('.city-item[data-city-id="' + id + '"], .skill-item[data-skill-id="' + id + '"], .theme-item[data-theme-id="' + id + '"]').prop('checked', false);
        console.log(id)
        $(this).parent().remove();


        if ($('#badge-container .label-item').length === 0) {
            $('#clear-all').hide(); // Set display property to none
        }

        filterData();
    });

    $(document).on('click', '#clear-all-btn', function () {
        $('#badge-container').empty();
        $('.city-item, .skill-item, .theme-item').prop('checked', false);
        $(this).hide();
        filterData();
    });


    $(document).on('click', '.city-item', filterData);

    $(document).on('click', '.skill-item', filterData);

    $(document).on('click', '.theme-item', filterData);

    $('#search').on('input', filterData);

    $('#sortkey').on('change', filterData);

    $(document).on('click', '.btn-grid', gridList);

    $(document).on('click', '.btn-list', showList);

});


function filterData() {
    var selectedCountryIds = [];

    var count = 0;


    var countryId = $(this).data('country-id');

    if ($(this).is(':checked')) {
        selectedCountryIds.push(countryId);
    } else {
        selectedCountryIds.splice(selectedCountryIds.indexOf(countryId), 1);
    }

    var selectedCityIds = $('.city-item:checked').map(function () {
        return {
            id: $(this).data('city-id'),
            label: $(this).siblings('label').text()
        };
    }).get();

    var selectedSkillIds = $('.skill-item:checked').map(function () {
        return {
            id: $(this).data('skill-id'),
            label: $(this).siblings('label').text()
        };
    }).get();


    var selectedThemeIds = $('.theme-item:checked').map(function () {
        return {
            id: $(this).data('theme-id'),
            label: $(this).siblings('label').text()
        };
    }).get();

    var searchTerm = $('#search').val();


    var labelHtml = '';

    selectedCityIds.forEach(function (city) {
        labelHtml += '<div class="label-item user-select-none" data-city-id="' + city.id + '">' + city.label + '<i class="bi bi-x cancel-icon" style="cursor: pointer;" data-city-id="' + city.id + '"></i></div>';
    });

    selectedSkillIds.forEach(function (skill) {
        labelHtml += '<div class="label-item user-select-none" data-skill-id="' + skill.id + '">' + skill.label + '<i class="bi bi-x cancel-icon" style="cursor: pointer;" data-skill-id="' + skill.id + '"></i></div>';
    });

    selectedThemeIds.forEach(function (theme) {
        labelHtml += '<div class="label-item user-select-none" data-theme-id="' + theme.id + '">' + theme.label + '<i class="bi bi-x cancel-icon" style="cursor: pointer;" data-theme-id="' + theme.id + '"></i></div>';
    });

    $('#badge-container').html(labelHtml);


    var clearAllHtml = '<a id="clear-all-btn" class="text-decoration-none" style="font-size: 15px; color: #414141; height: 18px; cursor: pointer;">Clear All</a>';
    if ($('#badge-container').children().length > 0) {
        $('#badge-container').append(clearAllHtml);
    }

    var sortBy = $('#sortkey').val();
    console.log(sortBy)



    $.ajax({
        type: 'GET',
        url: 'Home/Mission',
        data: {
            countryId: selectedCountryIds,
            cityId: selectedCityIds.map(function (city) { return city.id; }).join(','),
            skillId: selectedSkillIds.map(function (skill) { return skill.id; }).join(','),
            themeId: selectedThemeIds.map(function (theme) { return theme.id; }).join(','),
            keyword: searchTerm,
            sortBy: sortBy
        },
        success: function (data) {
            console.log(data)
            $("#m123456").html(data);
        },
        error: function (xhr, status, error) {
            alert('Error: ' + error);
        }
    });
}

function showList(e) {
    var $gridCont = $('.grid-container');
    e.preventDefault();
    $gridCont.addClass('list-view');
}
function gridList(e) {
    var $gridCont = $('.grid-container')
    e.preventDefault();
    $gridCont.removeClass('list-view');
}












