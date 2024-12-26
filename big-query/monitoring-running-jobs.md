# Checking on Your BigQuery Jobs: A Quick Guide

Need to see which BigQuery jobs are currently running in your GCP project? Here's how:

**Why Monitor?**

- **Resource Management:** Identify resource-intensive queries.
- **Performance Optimization:** Find and fix slow queries.
- **Cost Control:** Spot long-running, expensive jobs.
- **Debugging:** Troubleshoot errors in long-running queries.
- **Job Prioritization:** See which jobs are using resources.

**Methods to List Running Jobs**

**1. BigQuery Web UI:**

- Go to the BigQuery Web UI in your Google Cloud Console.
- Select **Job History** in the navigation panel to see all your jobs, including those currently running.

**2. `bq` Command-Line Tool:**

- Use `bq ls -j -a | grep RUNNING`.

**3. BigQuery Client Libraries (Python, Java, Node.js, Go, C#):**

- Provides programmatic access for automation.

#

**Example Queries:**

Here are two sample queries to demonstrate the job listing process:

- **Quick one:**

  ```sql
  SELECT
      5 * 7 AS multiplication,
      100 / 20 AS division,
      'Hello, ' || 'world!' AS concatenation;
  ```

- **Long runner (Slow Execution ~50 mins):**

  ```sql
  CREATE TEMP FUNCTION slow_function(n INT64) AS ((
  SELECT CAST(SUM(CAST(n AS BIGNUMERIC) * CAST(x AS BIGNUMERIC) / CAST(y AS BIGNUMERIC)) AS INT64)
    FROM UNNEST(GENERATE_ARRAY(1, 10000)) AS x, UNNEST(GENERATE_ARRAY(1, 10000)) AS y
  ));

    SELECT num, slow_function(num) AS result
    FROM UNNEST(GENERATE_ARRAY(1, 100)) AS num;
  ```

#

**Using the BigQuery Client Libraries (Most Flexible)**

The following code snippets demonstrate how to list running BigQuery jobs using various client libraries.

**Before running any code, make sure to:**

1. Install the respective client library for the language you're using.
2. Authenticate. The easiest way is to set up [Application Default Credentials (ADC)](https://cloud.google.com/docs/authentication/application-default-credentials). Refer to Google Cloud documentation for detailed instructions.

**1. Python**

```bash
pip install --upgrade google-cloud-bigquery
```

```python

from google.cloud import bigquery

def list_running_jobs(project_id):
  client = bigquery.Client(project=project_id)
  jobs = client.list_jobs(state_filter="RUNNING")
  job_map = {}
  if jobs:
      print("Running jobs:")
      for job in jobs:
          job_map[job.job_id] = job
          print(f"  Job ID: {job.job_id}, User: {job.user_email}, Created: {job.created}")
  else:
      print("No running jobs found.")
  return job_map

project_id = "your-gcp-project-id"  # Replace with your project ID
list_running_jobs(project_id)
```

**2. Java**

```java
import com.google.cloud.bigquery.BigQuery;
import com.google.cloud.bigquery.BigQueryOptions;
import com.google.cloud.bigquery.Job;
import com.google.cloud.bigquery.JobId;
import com.google.cloud.bigquery.QueryJobConfiguration;
import com.google.cloud.bigquery.TableResult;
import com.google.api.gax.paging.Page;

import java.util.HashMap;
import java.util.Map;

public class ListRunningJobs {

    public static Map<String, Job> listRunningJobs(String projectId) {
        BigQuery bigquery = BigQueryOptions.getDefaultInstance().getService();
        Map<String, Job> jobMap = new HashMap<>();

        Page<Job> jobs = bigquery.listJobs(BigQuery.JobListOption.stateFilter(BigQuery.JobState.RUNNING));
        if (jobs == null) {
            System.out.println("No running jobs found.");
            return jobMap;
        }

        System.out.println("Running jobs:");
        for (Job job : jobs.iterateAll()) {
            jobMap.put(job.getJobId().getJob(), job);
            System.out.println("  Job ID: " + job.getJobId().getJob() +
                    ", User: " + job.getUserEmail() +
                    ", Created: " + job.getStatistics().getCreationTime());
        }
        return jobMap;
    }

    public static void main(String[] args) {
        String projectId = "your-gcp-project-id"; // Replace with your project ID
        listRunningJobs(projectId);
    }
}
```

**3. Node.js**

```javascript
const { BigQuery } = require("@google-cloud/bigquery");

async function listRunningJobs(projectId) {
  const bigquery = new BigQuery({ projectId });
  const options = {
    stateFilter: ["RUNNING"],
  };
  const [jobs] = await bigquery.getJobs(options);
  const jobMap = {};
  if (jobs.length > 0) {
    console.log("Running jobs:");
    jobs.forEach((job) => {
      jobMap[job.id] = job;
      const metadata = job.metadata;
      console.log(
        `  Job ID: ${job.id}, User: ${metadata.user_email}, Created: ${new Date(
          metadata.creationTime
        ).toUTCString()}`
      );
    });
  } else {
    console.log("No running jobs found.");
  }
  return jobMap;
}

const projectId = "your-gcp-project-id"; // Replace with your project ID
listRunningJobs(projectId);
```

**4. Go**

```go
package main

import (
	"context"
	"fmt"
	"log"
	"time"
	"google.golang.org/api/iterator"
	"[invalid URL removed]"
)

func listRunningJobs(projectID string) (map[string]*bigquery.Job, error) {
	ctx := context.Background()
	client, err := bigquery.NewClient(ctx, projectID)
	if err != nil {
		return nil, fmt.Errorf("bigquery.NewClient: %v", err)
	}
	defer client.Close()
    jobMap := make(map[string]*bigquery.Job)
	it := client.Jobs(ctx)
	it.State = bigquery.Running
	fmt.Println("Running jobs:")
	for {
		job, err := it.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return nil, err
		}
        jobMap[job.ID()] = job
		status := job.LastStatus()
		fmt.Printf("  Job ID: %s, User: %s, Created: %s\n", job.ID(), status.UserEmail, time.Unix(job.CreationTime/1000, 0).Format(time.RFC3339))
	}
    if len(jobMap) == 0 {
        fmt.Println("No running jobs found")
    }
	return jobMap, nil
}

func main() {
	projectID := "your-gcp-project-id" // Replace with your project ID
	listRunningJobs(projectID)
}
```

**5. C#**

```c#
using Google.Cloud.BigQuery.V2;
using System;
using System.Collections.Generic;

public class ListRunningJobs
{
    public static Dictionary<string, BigQueryJob> ListJobs(string projectId)
    {
        var client = BigQueryClient.Create(projectId);
        var jobMap = new Dictionary<string, BigQueryJob>();
        Console.WriteLine("Running jobs:");
        var jobs = client.ListJobs(projectId, new ListJobsOptions { StateFilter = JobState.Running });
        foreach (var job in jobs)
        {
            jobMap[job.Reference.JobId] = job;
            Console.WriteLine($"  Job ID: {job.Reference.JobId}, User: {job.UserEmail}, Created: {job.Statistics.CreationTime}");
        }
        if(jobMap.Count == 0){
            Console.WriteLine("No running jobs found");
        }
        return jobMap;
    }

    public static void Main(string[] args)
    {
        string projectId = "your-gcp-project-id"; // Replace with your project ID
        ListJobs(projectId);
    }
}
```

Remember to replace `your-gcp-project-id` with your actual Google Cloud project ID in each code snippet.

Conclusion

The BigQuery client libraries offer a flexible way to monitor running jobs. You can integrate this functionality into applications, build dashboards, and create automated alerts to manage your BigQuery workload effectively. Using the provided code snippets in Python, Java, Node.js, Go and C#, you can easily adapt the solution to your preferred programming language and environment.
