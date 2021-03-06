var anOpen = [];
var sImageUrl = "http://qa.kleer.la/wp-content/uploads/2011/03/";
//sImageUrl = "./DataTables-1.9.1/media/images/";

var oTable;
$(document).ready(function() {
	oTable = $('#cursos').dataTable( {
		"bLengthChange": false,
		"sAjaxSource": '/entrenamos/eventos/pais/todos',
		"aoColumns": [
			{ "sWidth": "5%" },
			{ "sWidth": "75%" },
			{ "sClass": "right", "sWidth": "20%" }
		],
		"aaSorting": [],
		"bSort": false,
		"bPaginate": false,
		"oLanguage": {
			"sZeroRecords":  "<div class=\"alert alert-warning\">Cargando...</div>",
			"sInfo":         "<div class=\"alert alert-info\">Mostrando desde _START_ hasta _END_ de _TOTAL_ registros</div>",
			"sInfoEmpty":    "",
			"sInfoFiltered": "<div class=\"alert alert-info\">(filtrado de _MAX_ registros en total)</div>",
			"sInfoPostFix":  "",
			"sSearch":       "Buscar:",
			"sUrl":          ""
		},
		"fnInitComplete": function(oSettings, json) {
			oSettings.oLanguage.sZeroRecords = "<div class=\"alert alert-warning\">No tenemos cursos que cumplan con ese criterio pero nos gustaría que nos contactes a <a href=\"mailto:hola@kleer.la\">hola@kleer.la</a> con tu inquietud.</div>";
		}
	});

	// Cuelgo los handlers de los clicks
	$("ul#country-filter > li > a").on("click", function(event) {
		event.preventDefault();

		var newSource = $(this).attr("href");
		oTable.fnReloadAjax(newSource);

		var containerUl = $(this).parent().parent();
		containerUl.children("li").removeClass("active");

		var clickedLi = $(this).parent();
		clickedLi.addClass("active");
	});
});

$.fn.dataTableExt.oApi.fnReloadAjax = function ( oSettings, sNewSource, fnCallback, bStandingRedraw )
{
    if ( typeof sNewSource != 'undefined' && sNewSource != null ) {
        oSettings.sAjaxSource = sNewSource;
    }
 
    // Server-side processing should just call fnDraw
    if ( oSettings.oFeatures.bServerSide ) {
        this.fnDraw();
        return;
    }
 
    this.oApi._fnProcessingDisplay( oSettings, true );
    var that = this;
    var iStart = oSettings._iDisplayStart;
    var aData = [];
  
    this.oApi._fnServerParams( oSettings, aData );
      
    oSettings.fnServerData.call( oSettings.oInstance, oSettings.sAjaxSource, aData, function(json) {
        /* Clear the old information from the table */
        that.oApi._fnClearTable( oSettings );
          
        /* Got the data - add it to the table */
        var aData =  (oSettings.sAjaxDataProp !== "") ?
            that.oApi._fnGetObjectDataFn( oSettings.sAjaxDataProp )( json ) : json;
          
        for ( var i=0 ; i<aData.length ; i++ )
        {
            that.oApi._fnAddData( oSettings, aData[i] );
        }
          
        oSettings.aiDisplay = oSettings.aiDisplayMaster.slice();
          
        if ( typeof bStandingRedraw != 'undefined' && bStandingRedraw === true ) {
            oSettings._iDisplayStart = iStart;
            that.fnDraw( false );
        }
        else {
            that.fnDraw();
        }
          
        that.oApi._fnProcessingDisplay( oSettings, false );
          
        /* Callback user function - for event handlers etc */
        if ( typeof fnCallback == 'function' && fnCallback != null ) {
            fnCallback( oSettings );
        }
    }, oSettings );
};
