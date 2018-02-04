

# checking and installing required libraries
require(RColorBrewer) 	|| install.packages("RColorBrewer");
require(plotly) 		|| install.packages("plotly");

require(bigrquery) 		|| install.packages("bigrquery");
require(devtools) 		|| install.packages("devtools");
require(devtools);
require(ISBCGCExamples) || install_github("isb-cgc/examples-R", build_vignettes=TRUE);



# set the Google Cloud Platform project id under which these queries will run
project = "dauntless-loop-183621";


DisplayAndDispatchQuery <- function(queryUri) {
	# Read in the SQL from a file or URL
	querySql <- readChar(queryUri, nchars=1e6);
	
	# Find and replace the table name placeholder with our table name
	querySql <- sub("@THE_TABLE", theTable, querySql, fixed=TRUE);
	
	# Display the updated SQL
	# cat(querySql);
	
	# Dispatch the query to BigQuery for execution
	query_exec(querySql, project, use_legacy_sql = FALSE);
}

## Auto-refreshing stale OAuth token



