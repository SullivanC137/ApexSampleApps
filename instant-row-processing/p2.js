// JS code, exclusively loaded and called from page 2, Sample App - Instant row processing
// Calls page ajax processes

var apprCount = 0;
var rejCount = 0;

// page constants
const p2Const = {
  colors: {  //custom colors used
    reportRowGreen: '#4cb3697e',
    reportRowRed:   '#e53935',
    reportRowGrey:  '#e6e6e6'
  },
  duration: { // durations
    rowAnimation: 300,  // Rows fade out when approving or rejecting
    flash:        300   // Button, Tabs flash when changed
  },
  selector: { // various selectors
    approvedReport      : '#report_approved',           // Report region Approved Prices
    rejectedReport      : '#report_rejected',           // Report region Rejected Prices
    approvedReportHeader: '#report_approved_heading',   // Report header on region Approved Prices
    rejectedReportHeader: '#report_rejected_heading',   // Report header on region Rejected Prices
    approvedTab:          '#report_approved_tab span',  // Approved tab in RDS
    rejectedTab:          '#report_rejected_tab span',  // Rejected tab in RDS
    saveButton:           '#save_objects'               // Save button label
  },
  status: {
    approved: 'APP', // Approval status "APPROVED"
    rejected: 'REJ'  // Approval status "REJECTED"
  },
  customClass: {
    approve: 'approve-row',  //Added class to report row, used as selector in Dynamic Action
    reject:  'reject-row'
  },
  dataRow: {
    object_id   : 'object_id',
    object_type : 'object_type',
    object_name : 'object_name'
  }
};
// Function animates report row before Send action
// adds a spinner and green backgroud if approved, red if rejected
function animateRowBeforeSend(pRow, pStatus) {
  var lSpinner$ = apex.util.showSpinner($(pRow));
  lSpinner$.remove;
  if (pStatus == p2Const.status.approved) {
    pRow.children().animate({
      'backgroundColor': p2Const.colors.reportRowGreen
    }, p2Const.duration.rowAnimation);
    pRow.children().animate({
      'backgroundColor': p2Const.colors.reportRowGrey
    }, p2Const.duration.rowAnimation);
  }
  else if (pStatus == p2Const.status.rejected) {
    pRow.children().animate({
      'backgroundColor': p2Const.colors.reportRowRed
    }, p2Const.duration.rowAnimation);
    pRow.children().animate({
      'backgroundColor': p2Const.colors.reportRowGrey
    }, p2Const.duration.rowAnimation);
  }
}
// Function visually removes row from report
function removeRowFromReport(pRow) {
  // jQuery has difficulties animating inline elements
  // that's why we wrap them in a div, which is a block element
  pRow.children().wrapInner('<div>').children().fadeOut(400, function () {
    pRow.remove();  // visually remove the row from the report
  });
}
// Function changes Tab labels in Region Display Selector (RDS)
// Tab label flashes and updates with new value
function changeTabLabels(pStatus) {
  if (pStatus == p2Const.status.approved) {
    $(p2Const.selector.approvedTab)
      .fadeOut(p2Const.duration.flash)
      .text("Approved (" + apprCount + ")")
      .fadeIn(p2Const.duration.flash);
  } else if (pStatus == p2Const.status.rejected) {
    $(p2Const.selector.rejectedTab)
      .fadeOut(p2Const.duration.flash)
      .text("Rejected (" + rejCount + ")")
      .fadeIn(p2Const.duration.flash);
  }
}
// Function changes Region Headers
function changeRegionHeaders(pStatus) {
  if (pStatus == p2Const.status.approved) {
    $(p2Const.selector.approvedReportHeader).text("Approved (" + apprCount + ")");
  } else if (pStatus == p2Const.status.rejected) {
    $(p2Const.selector.rejectedReportHeader).text("Rejected (" + rejCount + ")");
  }
}
// Function changes button label
// Adds total rows to be processed to Label in parenthesis
function changesaveButton(pTotalRowsInQue) {
  $(p2Const.selector.saveButton)
    .fadeOut(p2Const.duration.flash)
    .text("Save (" + pTotalRowsInQue + ")")
    .fadeIn(p2Const.duration.flash);
}
// Function refreshes approved report
function refreshApprovedReport() {
    $(p2Const.selector.approvedReport).trigger('apexrefresh');
}
// Function refreshes rejected report
function refreshRejectedReport() {
    $(p2Const.selector.rejectedReport).trigger('apexrefresh');
}
//Function processRow handles all actions when thumbs-up or thumbs-down is clicked
function processRow(pSelector) {
  var tr = $(pSelector).closest('tr');                            // get the table row on which the user clicked
  tempTr = tr;
  pTempSelector = pSelector;
  $.ajax({                                                        // perform an asynchronous HTTP AJAX request using jQuery
    type: 'POST',
    url: 'wwv_flow.show',
    data: {
      p_flow_id: $('#pFlowId').val(),
      p_flow_step_id: $('#pFlowStepId').val(),
      p_instance: $('#pInstance').val(),
      x01: $(pSelector).parent().data(p2Const.dataRow.object_id),    // assign object_id to the g_x01 global variable
      x02: $(pSelector).parent().data(p2Const.dataRow.object_type),  // assign object_type to the g_x02 global variable
      x03: $(pSelector).parent().data(p2Const.dataRow.object_name),  // assign object_name to the g_x03 global variable
      x04: pSelector.className,
      p_request: 'APPLICATION_PROCESS=P2_PROCESS_REPORT_ROW'   // reference the application process
    },
    beforeSend:                                                   // executes while the AJAX call is being processed
      function () {
        if (pSelector.classList.contains(p2Const.customClass.approve)) {
          animateRowBeforeSend(tr, p2Const.status.approved)
        } else if (pSelector.classList.contains(p2Const.customClass.reject)) {
          animateRowBeforeSend(tr, p2Const.status.rejected)
        }
      },
    success:                                                      // to be called if the request succeeds
      function (pData) {
        if (pSelector.classList.contains(p2Const.customClass.approve)) {
          apprCount = pData.output[0].l_total_approved;
          changeRegionHeaders(p2Const.status.approved)
          changeTabLabels(p2Const.status.approved)
          refreshApprovedReport()
        } else if (pSelector.classList.contains(p2Const.customClass.reject)) {
          rejCount = pData.output[0].l_total_rejected;
          changeRegionHeaders(p2Const.status.rejected)
          changeTabLabels(p2Const.status.rejected)
          refreshRejectedReport()
        }
        changesaveButton(apprCount + rejCount)
        removeRowFromReport(tr)
      }
  });
}

//Function getTotalValues gets total rows and is executes on page load
function getTotalValues() {
  $.ajax({                                                        // perform an asynchronous HTTP AJAX request using jQuery
    type: 'POST',
    url: 'wwv_flow.show',
    data: {
      p_flow_id: $('#pFlowId').val(),
      p_flow_step_id: $('#pFlowStepId').val(),
      p_instance: $('#pInstance').val(),
      p_request: 'APPLICATION_PROCESS=P2_GET_TOTAL_VALUES'   // reference the application process
    },
    success:                                                 // to be called if the request succeeds
      function (pData) {
        apprCount = pData.output[0].l_total_approved;
        rejCount = pData.output[0].l_total_rejected;
        changeRegionHeaders(p2Const.status.approved)
        changeRegionHeaders(p2Const.status.rejected)
        changeTabLabels(p2Const.status.approved)
        changeTabLabels(p2Const.status.rejected)
        changesaveButton(apprCount + rejCount)
      }

  })
}

// Constant p2 serves as the API to the Application Builder
// Object structure aims to reflect event listeners, event types, call timing etc
const p2 = {
  dynamicAction: {
    onClick: {
      jQuerySelector: function (pTriggeringElement) {
        processRow(pTriggeringElement);
      }
    }
  },
  executeWhenPageLoads: function(){
    getTotalValues()
  }
};

// Sources:
// link:https://apexplained.wordpress.com/2012/02/12/instant-row-deletion-from-report/
// https://explorer.co.uk/calling-plsql-from-javascript/
