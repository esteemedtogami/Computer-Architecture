#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <sys/resource.h>

// need just a main function, no args

int main(void)
{

  // some local variables 

  pid_t   pid, ppid;
  int     ruid, rgid, euid, egid;
  int     priority;
  char    msg_buf[100];
  int     msg_pipe[2];

  // use the pipe() system call to create the pipe

  if(pipe(msg_pipe) == -1)
    {
    perror("failed in Parent pipe creation:");
    exit(7);
    }

  // use various system calls to collect and print process details

  printf("\nThis is the Parent process report:\n");
  pid  = getpid();
  ppid = getppid();
  ruid = getuid();
  euid = geteuid();
  rgid = getgid();
  egid = getegid();
  priority = getpriority(PRIO_PROCESS, 0);

  printf("\nPARENT PROG:  Process ID is:\t\t%d\n\
PARENT PROC:  Process parent ID is:\t%d\n\
PARENT PROC:  Real UID is:\t\t%d\n\
PARENT PROC:  Real GID is:\t\t%d\n\
PARENT PROC:  Effective UID is:\t\t%d\n\
PARENT PROC:  Effective GID is:\t\t%d\n\
PARENT PROC:  Process priority is:\t%d\n",
	 pid, ppid, ruid, rgid, euid, egid, priority);

  printf("\nPARENT PROC: will now create child, write pipe,\n \
and do a normal termination\n");

  // use the sprintf() call to build a message to write into the pipe
  // and dont forget to write the message into the pipe before parent exits
  //
  sprintf(msg_buf, "I was the parent and my PID is: %d\n", pid);

  // now use the fork() call to create the child:
  //
  // format is:
  //
  switch (pid = fork()){
          case -1: // if the call failes
	    perror("fork failed");
	    exit(4);

  default: // this is the parent's case                                                                                           
    // parent must write message to pipe and                                                                               
    // do a normal exit                                                                                                    
    printf("PARENT: Created child with PID %d \n", pid);
    break;


          case 0:  // this is the child's case
	           // child must create and print report
                   // child must read pipe message and print 
	           // a modified version of it to output
	           // child must do a normal exit

	    /**********CHILD CODE****************/

	    printf("\nThis is the child process report:\n");
	    pid  = getpid();
	    ppid = getppid();
	    ruid = getuid();
	    euid = geteuid();
	    rgid = getgid();
	    egid = getegid();
	    priority = getpriority(PRIO_PROCESS, 0);

	    printf("\nCHILD PROG:  Process ID is:\t\t%d\n\
CHILD PROC:  Process parent ID is:\t%d\n\
CHILD PROC:  Real UID is:\t\t%d\n\
CHILD PROC:  Real GID is:\t\t%d\n\
CHILD PROC:  Effective UID is:\t\t%d\n\
CHILD PROC:  Effective GID is:\t\t%d\n\
CHILD PROC:  Process priority is:\t%d\n",
		   pid, ppid, ruid, rgid, euid, egid, priority);

     printf("\nCHILD PROC: will now read pipe and report parent message:\n");

	    read(msg_pipe[0], msg_buf, 100);
  
	    printf("CHILD PROC: parent's msg is %s\n", msg_buf);
	    sleep(1);
	    printf("CHILD PROC: Process parent ID now is:   %d\n",
		   getppid());
	    printf("CHILD PROC: ### Goodbye ###\n");
	    exit(0);
	    break;
  } // switch and child end
  write(msg_pipe[1], msg_buf, strlen(msg_buf));
  exit(0);
  return 0;
}
