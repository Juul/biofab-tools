

var Constrainer = {

    nullfunc: function() {
        return null;
    },

    hooks: {
        expression_level: this.nullfunc        
    },

    init: function(node_id, p) {
        this.node_id = node_id;
        $(this.node_id).onchange = this.query_handler.bindAsEventListener(this);

        this.p = Object.extend({
            results_id: 'results',
            query_pause: 200
        }, p);

        this.spinner = document.createElement('IMG');
        this.spinner.className = 'spinner';
        this.spinner.src = '/assets/spinner.gif';

    },

    loading: function() {
        $(this.p.results_id).innerHTML = '';
        $(this.p.results_id).appendChild(this.spinner);
    },

    query_handler: function(e) {
        Event.stop(e);
        this.query({});
        return false;
    },

    query: function(p) {
        if(this.prev_query_time) {
            if((Date.getTime() - this.prev_query_time) < query_pause) {
                return false;
            }
        }
        this.loading();
        this.do_query(p);
        return false;
    },

    do_query: function(p) {

        new Ajax.Request('/constraint/query', {
            method: 'get',
            parameters: Object.extend({
                expression_level: this.hooks.expression_level(),
                tolerance: $('tolerance').value,
                promoter_contains: $('promoter_contains').value,
                promoter_not_contains: $('promoter_not_contains').value,
                utr_contains: $('utr_contains').value,
                utr_not_contains: $('utr_not_contains').value
            },p || {}),
            onSuccess: this.query_success.bindAsEventListener(this),
            onFailure: this.query_failure.bindAsEventListener(this)
        });


    },

    

    query_success: function(transport) {
        $(this.p.results_id).innerHTML = transport.responseText;
    },

    query_failure: function(transport) {
        $(this.p.results_id).innerHTML = "<span style='color:red'>An error occurred: " + transport.responseText + ".</span>";
    },


    toggle: function(type, id) {
        var types = ['utr', 'promoter'];
        var i, cur, cur_seq_id, cur_tab_id;
        for(i=0; i < types.length; i++) {
            cur = types[i];
            cur_seq_id = cur + '_seq_' + id;
            cur_tab_id = cur + '_tab_' + id;
            if(cur == type) {
                $(cur_seq_id).toggle();
                if($(cur_seq_id).visible()) {
                    $(cur_tab_id).addClassName('tab');
                    $(cur_tab_id).style.borderColor = 'black';
                } else {
                    $(cur_tab_id).removeClassName('tab');
                    $(cur_tab_id).style.borderColor = 'transparent';
                }
            } else {
                if($(cur_seq_id).visible()) {
                    $(cur_seq_id).toggle();
                    $(cur_tab_id).removeClassName('tab');
                    $(cur_tab_id).style.borderColor = 'transparent';
                }                
            }
        }
    },

    more_options: function(show) {
        if(show) {
            $('more_options').show();
            $('more_options_link_container').hide();
        } else {
            $('tolerance').value = 100;
            $('promoter_contains').value = '';
            $('utr_contains').value = '';
            $('promoter_not_contains').value = '';
            $('utr_not_contains').value = '';
            $('more_options').hide();
            $('more_options_link_container').show();
        }
    }
    
};