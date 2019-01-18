
#----------------------------------------------------------------------
#  Makefile : parallel_jacobi
#  Version  : 1                                                         
#  Author   : Claire Henriroux, Antariksh Dicholkar, Ashkhen Nalbandyan                                                         
#  Created  : 15-01-2019
#----------------------------------------------------------------------
SHELL       = /bin/sh
TARGET      = parallel_jacobi.exe
#----------------------------------------------------------------------
#  Compiler settings (Linux)
#----------------------------------------------------------------------
F77         = f95
CC          = cc
DEBUG       = -C
DEBUG       = 
OPT         = 
FFLAGS      = $(OPT) -free -g -fast -xO3 -xopenmp $(DEBUG) #-xvpara -xO3
CFLAGS      = -O
LD          = $(F77)
LDFLAGS     = 
CPP         = /lib/cpp
DEFINE      = 
LIBS        = 

#----------------------------------------------------------------------
#  Search path for RCS files                                           
#----------------------------------------------------------------------
VPATH = ./RCS

#----------------------------------------------------------------------
#  Additional suffix rules                                             
#----------------------------------------------------------------------
.SUFFIXES : .inc .inc,v .f,v .c,v
.f,v.f :
	 co $*.f

.c,v.c :
	 co $*.c

.inc,v.inc :
	 co $*.inc

#----------------------------------------------------------------------
#  Binary directory
#----------------------------------------------------------------------
bindir      = $(HOME)/bin

#----------------------------------------------------------------------
#  Default target
#----------------------------------------------------------------------
all: $(TARGET)

#----------------------------------------------------------------------
#  Object files:                                                       
#  NOTE: you HAVE to sort the objects files such that no file will 
#  depend on files below it ! in this example, the diffuse2.f and .o
#  depends on all he module files (i named them m_*.f), and the m_init
#  depends (USE) the m_diffuse; thus m_diffuse HAS to be compiled 
#  before m_init and before diffuse2
#----------------------------------------------------------------------
OBJS =	global_data.o\
	output.o\
	write_output.o\
	output_data.o\
	iter_jacobi.o\
	iter_gauss_siedel.o\
	frobenius_norm.o\
	init_test.o\
	init.o\
	input.o\
	alloc.o\
	main.o

#----------------------------------------------------------------------
#  Dependencies:                                                       
#  NOTE: add the dependencies here explicitly ! 
#  
#----------------------------------------------------------------------
main.o: main.f90 input.o alloc.o init.o init_test.o iter_jacobi.o output.o global_data.o iter_gauss_siedel.o frobenius_norm.o
	$(F77) $(FFLAGS)  -c main.f90
output.o: output.f90 global_data.o
	$(F77) $(FFLAGS)  -c output.f90
write_output.o: write_output.f90 global_data.o
	$(F77) $(FFLAGS)  -c write_output.f90	
output_data.o: output_data.f90 global_data.o
	$(F77) $(FFLAGS)  -c output_data.f90		
iter_gauss_siedel.o: iter_gauss_siedel.f90 global_data.o frobenius_norm.o
	$(F77) $(FFLAGS)  -c iter_gauss_siedel.f90
iter_jacobi.o: iter_jacobi.f90 global_data.o frobenius_norm.o
	$(F77) $(FFLAGS)  -c iter_jacobi.f90
frobenius_norm.o: frobenius_norm.f90 global_data.o
	$(F77) $(FFLAGS)  -c frobenius_norm.f90	
init.o: init.f90 global_data.o
	$(F77) $(FFLAGS)  -c init.f90
init_test.o: init_test.f90 global_data.o
	$(F77) $(FFLAGS)  -c init_test.f90
alloc.o: alloc.f90 global_data.o
	$(F77) $(FFLAGS)  -c alloc.f90
input.o: input.f90 global_data.o
	$(F77) $(FFLAGS)  -c input.f90
global_data.o: global_data.f90
	$(F77) $(FFLAGS)  -c global_data.f90

#----------------------------------------------------------------------
#  link                                                                
#----------------------------------------------------------------------
$(TARGET): $(OBJS)
	$(LD) -o $(TARGET) $(LDFLAGS) $(OBJS) $(LIBS)

#----------------------------------------------------------------------
#  Install                                                             
#----------------------------------------------------------------------
install: $(TARGET)
	(cp -f $(TARGET) $(bindir))

#----------------------------------------------------------------------
#  Run                                                                 
#----------------------------------------------------------------------
run: $(TARGET)
	$(TARGET)

#----------------------------------------------------------------------
#  Clean                                                               
#----------------------------------------------------------------------
new: cleanall diffuse2
cleanall:
	 rm -f $(OBJS)
	 rm -f *.lst
	 rm -f *.mod
	 rm -f *.l
	 rm -f *.L

clean:
	 rm -f __*.f
	 rm -f *.lst

