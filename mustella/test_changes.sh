#!/bin/bash
################################################################################
##
##  Licensed to the Apache Software Foundation (ASF) under one or more
##  contributor license agreements.  See the NOTICE file distributed with
##  this work for additional information regarding copyright ownership.
##  The ASF licenses this file to You under the Apache License, Version 2.0
##  (the "License"); you may not use this file except in compliance with
##  the License.  You may obtain a copy of the License at
##
##      http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.
##
################################################################################
##
## test_changes.sh - runs mini_run.sh -changes and runs mini_run-failures if
## there are failures
##

numlines=0
if [ -s changes.txt ]
then
sh ./mini_run.sh -changes
if [ -s failures.txt ]
then
sh ./mini_run.sh -failures
fi
else
	echo "no changes.txt or nothing in it"
	exit
fi
if [ -s failures.txt ]
then
    numlines=`wc -l failures.txt | awk {'print $1'}`
    echo "$numlines tests failed"
else
    numlines=`wc -l results.txt | awk {'print $1'}`
	let "numlines = $numlines - 19"
    echo "$numlines tests passed"
fi