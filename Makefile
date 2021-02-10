##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## Makefile
##

DEFAULT          = "\033[0m"
GREEN            = "\033[0;32m"
YELLOW           = "\e[1;33m"
BLUE             = "\033[1;34m"
RED              = "\033[1;31m"
VIOLET           = "\e[1;35m"

ECHO            = /bin/echo -e

DATE             := $(shell date +"%d %h %g:%R")

NAME            = pushswap_checker

CFLAGS            += -Wall -Wextra -Werror -Iinclude

CHECKHEADERS    =

SRCS            =     ./pushswap_checker.hs

CC                = ghc

$(NAME):		printDate $(OBJ) $(CHECKHEADERS)
				@$(CC) -o $(NAME) $(SRCS)
				@rm -f *.o
				@rm -f *.hi
				@$(ECHO) $(YELLOW)"Compilation  --->"$(GREEN)"  [OK]  Tout a compilé correctement. "
				@$(ECHO) $(YELLOW)"Binaire      --->"$(VIOLET)"  "$(NAME)$(DEFAULT)
				@$(ECHO) $(YELLOW)"Date         --->"$(BLUE)"  "$(DATE)$(DEFAULT)

all:			$(NAME)

debug:			CFLAGS += -g
debug:			printDebug
debug:			re

clean:			printDate
				@rm -f *.o
				@rm -f *.hi
				@$(ECHO) $(YELLOW)"Clean        ---> "$(GREEN)" [OK]"$(DEFAULT)

fclean:			printDate clean
				@rm -f $(NAME)
				@$(ECHO) $(YELLOW)"Fclean       ---> "$(GREEN)" [OK]"$(DEFAULT)

re:				fclean all

printDebug:
				@$(ECHO) $(YELLOW)"Debug        ---> "$(GREEN)" [ACTIVATED]"$(DEFAULT)

printDate:
				@$(ECHO) $(YELLOW)"Date         --->"$(BLUE)"  "$(DATE)$(DEFAULT)

.PHONY:			all clean fclean re debug

.hs.o:
				@$(CC) -c $< -o $@  && \
				$(ECHO) $(YELLOW)"Compilation  --->"$(GREEN)"  [OK] "$(BLUE) $< $(DEFAULT) || \
				$(ECHO) $(YELLOW)"Compilation  --->"$(RED)"  [XX] "$(BLUE) $< $(DEFAULT)