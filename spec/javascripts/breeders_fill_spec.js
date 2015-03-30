describe('autofill workings', function() {
    /*

    need a $('#breeder_entry') listener
    need a callback breeder_ajax()
    need a response callback breeders_add()

     */


    it('right ajax params sent', function () {
        spyOn($, 'ajax');
        $melo = $('#breeder_entry');
        $melo.value = 'melo';
        $melo.trigger('keyup');
        expect($.ajax.calls.mostRecent().args[0]['url']).toEqual('breeders?name=melo')
    });

    it('creates a div', function () {
        expect($('.breeder_choice')).toExist();
    });

    it('right div is created', function () {
        json = getJSONFixture('breeder_list.json');
        expect(json[0]['id'] == 1).toBeTruthy();
    });
});