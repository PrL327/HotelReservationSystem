var template = $('#RoomReservation_ .Room_:first').clone();
var sectionsCount = 1;

//Add new section for Room Selection
$(document).on('click', '.addsection', function() {
  var template = $('#RoomReservation_ .Room_').clone();
  //define counter
  var sectionsCount = 1;
    //increment
    sectionsCount++;

    //loop through each input
    var section = template.clone().find(':input').each(function(){

        //set id to store the updated section number
        var newId = this.id + sectionsCount;

        //update for label
        $(this).prev().attr('for', newId);

        //update id
        this.id = newId;

    }).end()
    .appendTo('#RoomReservation_');
    return false;
});

//Adding More Breakfasts
$(document).on('click', '.addbreakfast', function() {
  var template = $('#BreakfastOption_1 .breakfasts:nth-of-type(1)').clone();
  //define counter
  var sectionsCount = 1;
    //increment
    sectionsCount++;

    //loop through each input
    var section = template.clone().find(':input').each(function(){

        //set id to store the updated section number
        var newId = this.id + sectionsCount;

        //update for label
        $(this).prev().attr('for', newId);

        //update id
        this.id = newId;

    }).end()
    .appendTo('#BreakfastOption_1');
    return false;
});

//Adding Services
$(document).on('click', '.addservices', function() {
  var template = $('#ServicesOption_ .services:nth-of-type(1)').clone();
  //define counter
  var sectionsCount = 1;
    //increment
    sectionsCount++;

    //loop through each input
    var section = template.clone().find(':input').each(function(){

        //set id to store the updated section number
        var newId = this.id + sectionsCount;

        //update for label
        $(this).prev().attr('for', newId);

        //update id
        this.id = newId;

    }).end()
    .appendTo('#ServicesOption_');
    return false;
});
//Show Payment
$(document).on('click', '.next', function() {
    $("#Payment_info").removeClass("hidden");;
});
