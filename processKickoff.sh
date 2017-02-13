#!/bin/bash

env="$1"

if [[ $env == 'prod' ]]; then
	#main server paths
	main_server_path='/home/administrator/ans_scanning/server/Backend/app.js';
	main_server_log_path='/home/administrator/ans_scanning/server/Backend/log.txt';
	main_server_error_log_path='/home/administrator/ans_scanning/server/Backend/err-log.txt';

	#bag tracking server paths
	bt_server_path='/home/administrator/ans_scanning/server/TrackingServer/index.js';
	bt_server_log_path='/home/administrator/ans_scanning/server/TrackingServer/log.txt';
	bt_server_error_log_path='/home/administrator/ans_scanning/server/TrackingServer/err-log.txt';

	#reporting server server paths
	reporting_server_path='/home/administrator/ans_scanning/server/ReportServer/app.js';
	reporting_server_log_path='/home/administrator/ans_scanning/server/ReportServer/log.txt';
	reporting_server_error_log_path='/home/administrator/ans_scanning/server/ReportServer/err-log.txt';

	#submission tracking server paths
	submission_server_path='/home/administrator/ans_scanning/server/SubmissionServer/index.js';
	submission_server_log_path='/home/administrator/ans_scanning/server/SubmissionServer/log.txt';
	submission_server_error_log_path='/home/administrator/ans_scanning/server/SubmissionServer/err-log.txt';
else
	#devlopment paths
	echo ""
fi

#other module commands
other(){
	echo "Commands available for Other Module";
	select yn in "PM2-log-rotate-100-mb"; do
    	case $yn in
		#rotate logs at 100 mb and enable compression
        PM2-log-rotate-100-mb )
         	command -v pm2 >/dev/null 2>&1 || { echo >&2 "Enabling log rotate for pm2 requires pm2 to be installed. Pm2 wasn't found on this system. Aborting."; exit 1; }
			pm2 set pm2-logrotate:max_size 100B
			pm2 set pm2-logrotate:compress true
			echo "SUCCESS. Log rotate is set to be performed at 100MB file size."
         	break;;        
    	esac
	done
}

#All module commands
all(){
	echo "Commands available for All Module";
	select yn in "Start" "Stop" "Restart" "Delete"; do
    	case $yn in		
        Start )
			#main
         	pm2 start $main_server_path --name main_server -o $main_server_log_path -e $main_server_error_log_path
			#bag tracking server
			pm2 start $bt_server_path --name bt_server -o $bt_server_log_path -e $bt_server_error_log_path
			#reporting server
			pm2 start $reporting_server_path --name reporting_server -o $reporting_server_log_path -e $reporting_server_error_log_path
			#submission server
			pm2 start $submission_server --name server1 -o $submission_server_log_path -e $submission_server_error_log_path
         	break;;        
		Stop )
			pm2 stop all
			break;;        
		Restart )
			pm2 reload all
			break;;        
		Delete )
			pm2 delete all
			break;;        
    	esac
	done
}

#Bag Tracking commands
submission(){
	echo "Commands available for Scanning Module";
	select yn in "Start" "Stop" "Reload" "Delete" "Status" "Error-logs-real-time" "Error-Logs-100-Lines" "Normal-logs-real-time" "Normal-Logs-100-Lines"; do
	    case $yn in	        	        	        
			Status )
				pm2 status				
				break;;
			Start )
				if [[ $env == 'prod' ]]; then
					pm2 start $submission_server --name server1 -o $submission_server_log_path -e $submission_server_error_log_path
				else
					echo "no command"
				fi
				break;;
			Stop )
				if [[ $env == 'prod' ]]; then
					pm2 stop submission_server
				else
					echo "no command"
				fi
				break;;
			Delete )
				if [[ $env == 'prod' ]]; then
					pm2 delete submission_server
				else
					echo "no command"
				fi
				break;;
			Reload )
				if [[ $env == 'prod' ]]; then
					pm2 reload submission_server
				else
					echo "no command"
				fi
				break;;
			#realtime error logs
			Error-logs-real-time )
				if [[ $env == 'prod' ]]; then
					pm2 logs --lines=100 --timestamp="YYYY-MM-DD HH:mm:ss Z" submission_server --err
				else
					echo "no command"
				fi
				break;;
			#get last 100 lines of error log
			Error-Logs-100-Lines )				
				if [[ $env == 'prod' ]]; then
					tail -n 100 $submission_server_error_log_path
				else
					echo "no command"
				fi
				break;;
			#realtime logs
			Normal-logs-real-time )
				if [[ $env == 'prod' ]]; then
					pm2 logs --lines=100 --timestamp="YYYY-MM-DD HH:mm:ss Z" submission_server --out
				else
					echo "no command"
				fi
				break;;
			#get last 100 lines log
			Normal-Logs-100-Lines )
				if [[ $env == 'prod' ]]; then
					tail -n 100 $submission_server_error_log_path
				else
					echo "no command"
				fi
				break;;			
	    esac
	done
}

reporting(){
	echo "Commands available for Reporting Module";
	select yn in "Start" "Stop" "Reload" "Delete" "Status" "Error-logs-real-time" "Error-Logs-100-Lines" "Normal-logs-real-time" "Normal-Logs-100-Lines"; do
	    case $yn in	        	        	        
			Status )
				pm2 status				
				break;;
			Start )
				if [[ $env == 'prod' ]]; then
					pm2 start $reporting_server_path --name reporting_server -o $reporting_server_log_path -e $reporting_server_error_log_path
				else
					echo "no command"
				fi
				break;;
			Stop )
				if [[ $env == 'prod' ]]; then
					pm2 stop reporting_server
				else
					echo "no command"
				fi
				break;;
			Delete )
				if [[ $env == 'prod' ]]; then
					pm2 delete reporting_server
				else
					echo "no command"
				fi
				break;;
			Reload )
				if [[ $env == 'prod' ]]; then
					pm2 reload reporting_server
				else
					echo "no command"
				fi
				break;;
			#realtime error logs
			Error-logs-real-time )
				if [[ $env == 'prod' ]]; then
					pm2 logs --lines=100 --timestamp="YYYY-MM-DD HH:mm:ss Z" server1 --err
				else
					echo "no command"
				fi
				break;;
			#get last 100 lines of error log
			Error-Logs-100-Lines )				
				if [[ $env == 'prod' ]]; then
					tail -n 100 $reporting_server_error_log_path
				else
					echo "no command"
				fi
				break;;
			#realtime logs
			Normal-logs-real-time )
				if [[ $env == 'prod' ]]; then
					pm2 logs --lines=100 --timestamp="YYYY-MM-DD HH:mm:ss Z" server1 --out
				else
					echo "no command"
				fi
				break;;
			#get last 100 lines log
			Normal-Logs-100-Lines )
				if [[ $env == 'prod' ]]; then
					tail -n 100 $reporting_server_error_log_path
				else
					echo "no command"
				fi
				break;;			
	    esac
	done
}

#Bag tracking commands
bagTracking(){
	echo "Commands available for Scanning Module";
	select yn in "Start" "Stop" "Reload" "Delete" "Status" "Error-logs-real-time" "Error-Logs-100-Lines" "Normal-logs-real-time" "Normal-Logs-100-Lines"; do
	    case $yn in	        	        	        
			Status )
				pm2 status				
				break;;
			Start )
				if [[ $env == 'prod' ]]; then
					pm2 start $bt_server_path --name bt_server -o $bt_server_log_path -e $bt_server_error_log_path
				else
					echo "no command"
				fi
				break;;
			Stop )
				if [[ $env == 'prod' ]]; then
					pm2 stop bt_server
				else
					echo "no command"
				fi
				break;;
			Delete )
				if [[ $env == 'prod' ]]; then
					pm2 delete bt_server
				else
					echo "no command"
				fi
				break;;
			Reload )
				if [[ $env == 'prod' ]]; then
					pm2 reload bt_server
				else
					echo "no command"
				fi
				break;;
			#realtime error logs
			Error-logs-real-time )
				if [[ $env == 'prod' ]]; then
					pm2 logs --lines=100 --timestamp="YYYY-MM-DD HH:mm:ss Z" bt_server --err
				else
					echo "no command"
				fi
				break;;
			#get last 100 lines of error log
			Error-Logs-100-Lines )				
				if [[ $env == 'prod' ]]; then
					tail -n 100 $bt_server_error_log_path
				else
					echo "no command"
				fi
				break;;
			#realtime logs
			Normal-logs-real-time )
				if [[ $env == 'prod' ]]; then
					pm2 logs --lines=100 --timestamp="YYYY-MM-DD HH:mm:ss Z" bt_server --out
				else
					echo "no command"
				fi
				break;;
			#get last 100 lines log
			Normal-Logs-100-Lines )
				if [[ $env == 'prod' ]]; then
					tail -n 100 $bt_server_error_log_path
				else
					echo "no command"
				fi
				break;;			
	    esac
	done
}

main(){
	echo "Commands available for main Module";
	select yn in "Start" "Stop" "Reload" "Delete" "Status" "Error-logs-real-time" "Error-Logs-100-Lines" "Normal-logs-real-time" "Normal-Logs-100-Lines"; do
	    case $yn in	        	        	        
			Status )
				pm2 status				
				break;;
			Start )
				if [[ $env == 'prod' ]]; then
					pm2 start $main_server_path --name main_server -o $main_server_log_path -e $main_server_error_log_path
				else
					echo "no command"
				fi
				break;;
			Stop )
				if [[ $env == 'prod' ]]; then
					pm2 stop main_server
				else
					echo "no command"
				fi
				break;;
			Delete )
				if [[ $env == 'prod' ]]; then
					pm2 delete main_server
				else
					echo "no command"
				fi
				break;;
			Reload )
				if [[ $env == 'prod' ]]; then
					pm2 reload main_server
				else
					echo "no command"
				fi
				break;;
			#realtime error logs
			Error-logs-real-time )
				if [[ $env == 'prod' ]]; then
					pm2 logs --lines=100 --timestamp="YYYY-MM-DD HH:mm:ss Z" main_server --err
				else
					echo "no command"
				fi
				break;;
			#get last 100 lines of error log
			Error-Logs-100-Lines )				
				if [[ $env == 'prod' ]]; then
					tail -n 100 $main_server_error_log_path
				else
					echo "no command"
				fi
				break;;
			#realtime logs
			Normal-logs-real-time )
				if [[ $env == 'prod' ]]; then
					pm2 logs --lines=100 --timestamp="YYYY-MM-DD HH:mm:ss Z" main_server --out
				else
					echo "no command"
				fi
				break;;
			#get last 100 lines log
			Normal-Logs-100-Lines )
				if [[ $env == 'prod' ]]; then
					tail -n 100 $main_server_error_log_path
				else
					echo "no command"
				fi
				break;;			
	    esac
	done
}

echo "Modules available"
select yn in "Main" "Bag-Tracking" "Submission" "Reporting" "Other" "All" ; do
    case $yn in
        Main )
         	main
         	break;;        
		Bag-Tracking )
			bagTracking
			break;;
		Submission )
			submission
			break;;
		Reporting )
			reporting
			break;;
		All )
			all
			break;;		
		Other )
			other
			break;;
    esac
done
