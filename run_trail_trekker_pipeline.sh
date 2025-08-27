
# Set up environment
cd /Users/madison/sqlmesh/sqlmesh-data-pipeline-summer

# Activate virtual environment if needed
source .venv/bin/activate

# Run sqlmesh with logging
echo "$(date): Starting sqlmesh run" >> ~/sqlmesh_cron.log
sqlmesh run >> ~/sqlmesh_cron.log 2>&1
echo "$(date): Completed sqlmesh run" >> ~/sqlmesh_cron.log