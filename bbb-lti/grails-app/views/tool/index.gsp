<html>
    <head>
        <title>BigBlueButton LTI Interface</title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
		<style>
		
		.table .cell a.btn-small {
			margin: 0 5px;
			width: 70px;
		}
		.table {
			font-size: 14px;
			vertical-align: middle;
		}
		
		</style>
    </head>
    <body>

<div class="container-fluid">
  <div class="row-fluid">

        <h1 style="text-align: center;">${resource_link_title}</h1>
		<h1 style="text-align: center;"><a title="Join" class="btn btn-success btn-large" href="${createLink(controller:'tool',action:'join')}">Join Session</a></h1>
        <hr />
		<h4>Past Recordings</h4>
		<p>Recorded sessions will appear only after all participants have disconnected and the session's multimedia is processed. Processing time will depend on a session's length and typically be completed within a few hours. <a href="http://firefox.com" target="_blank">Mozilla Firefox</a> or <a href="http://www.google.com/chrome" target="_blank">Google Chrome</a> is required for watching recordings.</p>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th class="header c0" style="text-align:center;" scope="col">Link</th>
                    <th class="header c1" style="text-align:center;" scope="col">Title</th>
                    <th class="header c3" style="text-align:center;" scope="col">Date</th>
                    <th class="header c4" style="text-align:center;" scope="col">Duration</th>
                    <g:if test="${ismoderator}">
                    <th class="header c5 lastcol" style="text-align:center;" scope="col">Tools</th>
                    </g:if>
                </tr>
            </thead>
            <tbody>
			<g:set var="num_recordings_listed" value="${0}"/>
            <g:each in="${recordingList}" var="r">
                <g:if test="${ismoderator || r.published == 'true'}">
					<g:set var="num_recordings_listed" value="${num_recordings_listed + 1}" />
	                <tr class="r0 lastrow">
	                    <td class="cell c0" style="text-align:center;">
	                    <g:each in="${r.playback}" var="p">
	                        <a title="${p.type}" target="_new" href="${p.url}">View ${p.type}</a>
	                    </g:each>
	                    </td>
	                    <td class="cell c1" style="text-align:center;">${r.name}</td>
	                    <td class="cell c3" style="text-align:center;">${new Date( Long.valueOf(r.startTime).longValue() ).format("MMMM d, yyyy 'at' h:mm a")}</td>
	                    <td class="cell c4" style="text-align:center;">
	                    <g:each in="${r.playback}" var="p">
		                    <g:if test="${p.type == 'slides'}">
		                        ${p.length} minutes
		                    </g:if>
		                    <g:if test="${p.type == 'presentation'}">
		                        ${p.length} minutes
		                    </g:if>
	                    </g:each>
	                    </td>
	                    <g:if test="${ismoderator}">
	                    <td class="cell c5 lastcol" style="text-align:center;">
	                      <g:if test="${r.published == 'true'}">
	                      <a title="Published (Click to Hide)" class="btn btn-small btn-success" href="${createLink(controller:'tool',action:'publish')}?bbb_recording_published=${r.published}&bbb_recording_id=${r.recordID}">Published</a>
	                      </g:if>
	                      <g:else>
	                      <a title="Unpublished (Click to Show)" class="btn btn-small btn-warning" href="${createLink(controller:'tool',action:'publish')}?bbb_recording_published=${r.published}&bbb_recording_id=${r.recordID}">Unpublished</a>
	                      </g:else>
	                      <a title="Delete" class="btn btn-small btn-danger" onClick="if(confirm('Are you sure to delete this recording?')) window.location='${createLink(controller:'tool',action:'delete')}?bbb_recording_id=${r.recordID}'; return false;" href="#">Delete</a>
	                    </td>
	                    </g:if>
	                </tr>
                </g:if>
            </g:each>
	        <g:if test="${num_recordings_listed == 0}">
				<tr><td colspan="5" style="text-align:center;"><em>No recordings available.</em></td></tr>
			</g:if>
			
            </tbody>
        </table>
        
	</div>
</div>

    </body>
</html>