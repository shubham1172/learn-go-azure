# Learn go while implementing Azure auto tag

The idea of this repo is to go step by step with the implementation of some more advanced concepts of go.

The focus here is how to work with third-party dependencies and how to deal with channel and timers using multi-thread

The different branches will have different status of the code so you can try the different problems and how they are solved.

The idea here is to use a real-world implementation to make these concepts more concrete and give a real-world implementation.

## Problem statement

The goal is to automatically tag azure resources with the name of the user that has created that resource, adding to that resource a tag called `Created-by`. Currently (2020-04-26) the only way to implement this it is to scan the activity log and based in the activities in the activity log and who has triggered that deployment update the tag for that resource.

## Pre-built code

Most of the code that you will be using for this exercise has been laid out already. We are going to focus only on the `execute updates` method in the file `main.go` since it is the hot path of our application where it spends most of the time and there is more space for optimization.

Some os the optimization considerations that we might take into account:
 1- Although each subscription can have multiple resources the number of subscriptions can grow to thousands of subscriptions.
 2- You should avoid time.sleep() when it is possible since this may keep the thread busy.
 3- The interval should be count after all the subscriptions have been processed.


# First Exercise.

Having the application waiting until one application finishes applying the tags to start making the queries in other application it is inefficient. How can we make sure that the calls to `evaluateStatus` are made in parallel but that we wait for all of them to finish before we start waiting for the interval?

The idea of this exercise is to introduce [goroutines](https://tour.golang.org/concurrency/1) you can find a good explanation about go-routines at https://gobyexample.com/goroutines and https://golangbot.com/goroutines/ the idea is to also introduce [wait groups](https://golang.org/pkg/sync/) you can find more information about wait-groups at https://gobyexample.com/waitgroups and https://tutorialedge.net/golang/go-waitgroup-tutorial/

After you finish this exercise the rest of the instructions and the code with that solution can be found in the branch `exercise-1`

# Second Exercise

Using the [time](https://golang.org/pkg/time/) package and [channels](https://tour.golang.org/concurrency/2) we can make something more elegant that would allow us to avoid using an infinite loop in the code (without a breaking clause), avoid the need of using sleep in the code and give the option to terminate the program. 

In this exercise the goal it is to modify the code to be using [channels](https://gobyexample.com/channels) and [tickers](https://gobyexample.com/tickers) to schedule the new runs of this code to be triggered by a new tick

You can find the result of this exercise and the rest os the instructions on the branch `exercise-2` 

# Third Exercise

Using d [channels](https://tour.golang.org/concurrency/2) again we should work on creating a rate limit to max the number of subscriptions being processed simultaneously to avoid throttling in the azure API so we want to limit the max number of subscriptions being processed at the same time to 5 

A tip for this exercise it is to remember to use [defer](https://gobyexample.com/defer) if you haven't used that yet in the other exercises this can make your code more elegant and easier to read. 

You can find the result of this exercise on the branch `exercise-3` 

# Stretch Goal

If you can in the last exercise imagine how using timmers and the channels. Can you create a rate limit in a way that you limit to a maximum of 20 requests per second in the azure API?