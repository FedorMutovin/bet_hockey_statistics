document.addEventListener('turbolinks:load', function() {
    let bet_event_type = document.querySelector('#bet_event_attributes_eventable_type')
    let bet_event_input_value = document.querySelector('#bet_event_attributes_eventable_id')
    let bet_team_selector = document.querySelector('.bet-team')
    let events = document.querySelectorAll('optgroup')

    bet_event_type.addEventListener('change', (e) => {

        bet_event_input_value.value = 0

        if(e.target.value === 'Total') {
            bet_team_selector.style.display = 'none'
        } else {
            bet_team_selector.style.display = ''
        }

        events.forEach(function (event) {
            if(event.label === e.target.value){
                event.style.display = ''
            } else {
                event.style.display = 'none'
            }
        })
    })
})