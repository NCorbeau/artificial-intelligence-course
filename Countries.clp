; Sztuczna inteligencja - Zadanie 1.
; 
; Maciej Głownia
; ----------------------------------
; System zadaje użytkownikowi kilka pytań i na podstawie profilu psychologicznego
; wywnioskowanego z odpowiedzi użytkownika, wnioskuje, w jakim kraju
; powinien zamieszkać użytkownik.
;
; Wstępna baza danych jest na razie bardzo minimalistyczna i niestety nieoparta
; na żadnych poważnych źródłach. Planuję ją rozszerzyć o więcej krajów
; i oprzeć na oficjalnych statystykach.
;-----------------------------------
; Instrukcja użycia:
; -(reset)
; -(run)

(defmodule MAIN
	(export ?ALL))

;
; Templates
;

(deftemplate MAIN::country
	(slot name (type STRING))
	(slot wealth (type INTEGER))
	(slot urbanization (type INTEGER))
	(slot freedom (type INTEGER))
	(slot tourist-value (type INTEGER))
	(slot language-group (type SYMBOL) (allowed-values germanic romance slavic hellenic japonic niger-congo oceanic sinitic arabic))
	(slot climate (type INTEGER)))

;
; Startup facts
;

(deffacts MAIN::startup
	(country (name "Polska")
		     (wealth 7)
		     (urbanization 7)
		     (freedom 8)
		     (tourist-value 8)
		     (language-group slavic)
		     (climate 5))

	(country (name "Holandia")
			 (wealth 9)
		     (urbanization 15)
		     (freedom 9)
		     (tourist-value 8)
		     (language-group germanic)
		     (climate 5))

	(country (name "Urugwaj")
			 (wealth 4)
		     (urbanization 4)
		     (freedom 8)
		     (tourist-value 5)
			 (language-group romance)
			 (climate 6))

	(country (name "Japonia")
			 (wealth 9)
		     (urbanization 13)
		     (freedom 7)
		     (tourist-value 8)
			 (language-group japonic)
			 (climate 6))

	(country (name "Argentyna")
			 (wealth 3)
		     (urbanization 3)
		     (freedom 4)
		     (tourist-value 9)
			 (language-group romance)
			 (climate 8))

	(country (name "Australia")
			 (wealth 8)
		     (urbanization 2)
		     (freedom 12)
		     (tourist-value 9)
			 (language-group germanic)
			 (climate 8))

	(country (name "Zjednoczone Emiraty Arabskie")
			 (wealth 9)
		     (urbanization 3)
		     (freedom 2)
		     (tourist-value 8)
			 (language-group arabic)
			 (climate 6))

	(country (name "Etiopia")
			 (wealth 1)
		     (urbanization 1)
		     (freedom 1)
		     (tourist-value 7)
			 (language-group niger-congo)
			 (climate 3))

	(country (name "Libia")
			 (wealth 3)
		     (urbanization 1)
		     (freedom 3)
		     (tourist-value 8)
			 (language-group arabic)
			 (climate 9))

	(country (name "Stany Zjednoczone")
			 (wealth 8)
		     (urbanization 9)
		     (freedom 9)
		     (tourist-value 8)
			 (language-group germanic)
			 (climate 7))

	(country (name "Francja")
			 (wealth 9)
		     (urbanization 9)
		     (freedom 8)
		     (tourist-value 8)
			 (language-group romance)
			 (climate 7))

	(country (name "Wielka Brytania")
			 (wealth 9)
		     (urbanization 9)
		     (freedom 8)
		     (tourist-value 7)
			 (language-group germanic)
			 (climate 7))

	(country (name "Chiny")
			 (wealth 5)
		     (urbanization 5)
		     (freedom 2)
		     (tourist-value 8)
			 (language-group sinitic)
			 (climate 3))

	(country (name "Grecja")
			 (wealth 5)
		     (urbanization 6)
		     (freedom 7)
		     (tourist-value 9)
			 (language-group hellenic)
			 (climate 9))

	(country (name "Meksyk")
			 (wealth 3)
		     (urbanization 4)
		     (freedom 4)
		     (tourist-value 9)
			 (language-group romance)
			 (climate 7))

	(country (name "Kanada")
			 (wealth 9)
		     (urbanization 4)
		     (freedom 9)
		     (tourist-value 8)
			 (language-group germanic)
			 (climate 3))

	(user-wealth 1)
	(user-urbanization 1)
	(user-freedom 1)
	(user-tv 1)
	(user-climate 1))

;
; Control rules
;

(defrule MAIN::begin
	=>
	(printout t crlf crlf crlf
		"Budzisz sie na samotnej wyspie po srodku jakiegos akwenu." crlf
		"Nie masz pojecia gdzie jestes, ani jak sie znalazles w tym" crlf
		"miejscu. Najwyrazniej masz amnezje. Rozgladasz sie" crlf
		"do okola. Twoja uwage przykuwa dziwny metalowy element" crlf
		"wystajacy zza skaly. Okrazasz skale. Twoim oczom ukazuje sie" crlf
		"wspanialy odrzutowiec. Drzwi sa otwarte. Niepewnie wchodzisz" crlf
		"do srodka. Okazuje sie, ze panel sterowaia wehikulu jest" crlf
		"wlaczony. Podchodzisz do panelu. Czytasz:" crlf crlf
		"Jestem autopilotem tego wspanialego odrzutowca. Odpowiedz mi" crlf
		"na kilka pytan, a powiem Ci, gdzie polecimy." crlf crlf)
	(focus REASONING SOLUTION))

(defmodule REASONING
	(export ?ALL)
	(import MAIN ?ALL))
;
; Questions
;

(defrule REASONING::guided
	(not (guided ?))
	=>
	(printout t crlf
		"Ile razy tygodniowo prosic o porade kogos bardziej doswiadczonego? ")
	(assert (guided =(read))))

(defrule REASONING::tolerant
	(not (tolerant ?))
	=>
	(printout t crlf
		"Ile razy tygodniowo zdarza Ci sie upomniec kogos za jego zachowanie? ")
	(assert (tolerant =(read))))

(defrule REASONING::adaptation
	(not (adaptation ?))
	=>
	(printout t crlf
		"Po ilu tygodniach zadomowilbys sie w calkiem nowej rodzinie? ")
	(assert (adaptation =(read))))

(defrule REASONING::wild
	(not (wild ?))
	=>
	(printout t crlf
		"Na ile tygodni mialbys ochote odizolowac sie od spoleczenstwa? ")
	(assert (wild =(read))))

(defrule REASONING::challenges
	(not (challenges ?))
	=>
	(printout t crlf
		"Ile masz aktualnie postanowien noworocznych? ")
	(assert (challenges =(read))))

(defrule REASONING::language-group
	(not (language-group ?))
	=>
	(printout t crlf
		"Do jakiej grupy nalezy Twoj rodzimy jezyk? " crlf
		"[slowianski=slavic, germanski=germanic, romanski=romance, japonski=japonic," crlf
		"arabski=arabic, hellenski=hellenic, chinski=sinitic] ")
	(assert (user-lg =(read))))

(defrule REASONING::temperature
	(not (temperature ?))
	=>
	(printout t crlf
		"Ile wedlug Ciebie powinna wynosic srednia roczna" crlf
		"temperatura powietrza? ")
	(assert (temperature =(read))))

(defrule REASONING::student
	(not (challenges ?))
	(not (adaptation ?))
	=>
	(printout t crlf
		"Jakie najczesciej dostawales w szkole oceny? ")
	(bind ?mark (read))
	(assert (challenges (* 2 ?mark)))
	(assert (adaptation (* 2 ?mark)))
	(assert (student ?mark)))

(defrule REASONING::tourist
	(not (tourist ?))
	=>
	(printout t crlf
		"Ile krajow odwiedziles w swoim zyciu? ")
	(assert (user-tv =(read))))

;
; "Purely" deductive rules
;

; lubi wyzwania => potrafi sie dostosowac
(defrule REASONING::adaptation-bis
	(not (adaptation ?))
	(challenges ?challenges)
	(test (> ?challenges 5))
	=>
	(assert (adaptation ?challenges)))

; bardzo nietolerancyjny => antyspoleczny
(defrule REASONING::antisocial
	(not (wild ?))
	(tolerant ?tolerant)
	(test (< ?tolerant 3))
	=>
	(assert (antisocial))
	(assert (wild ?tolerant)))

; dobry uczen powinien sie nauczyc tolerancji ;)
(defrule REASONING::tolerant-student
	(not (tolerant ?))
	(student ?mark)
	(test (>= ?mark 4))
	=>
	(assert (tolerant (* 2 ?mark))))

; uleglosc
(defrule REASONING::submissive
	(not (submissive))
	(adaptation ?adaptation)
	(guided ?guided)
	(test (> ?adaptation 5))
	(test (> ?guided 5))
	?uf <- (user-freedom ?user-freedom)
	=>
	(assert (submissive))
	(retract ?uf)
	(assert (user-freedom (- ?user-freedom 3))))

; ulegly => na pewno nie antyspoleczny
(defrule REASONING::wild-correction
	(not (w-corred))
	?wild <- (wild ?)
	(submissive)
	=>
	(assert (w-corred))
	(retract ?wild)
	(assert (wild 0)))


; nieuleglosc
(defrule REASONING::restive
	(not (restive))
	?uf <- (user-freedom ?user-freedom)
	(guided ?guided)
	(adaptation ?adaptation)
	(test (<= ?adaptation 5))
	(test (<= ?guided 5))
	=>
	(assert (restive))
	(retract ?uf)
	(assert (user-freedom (+ ?user-freedom 3))))

; ulegly i tolerancyjny => posluszny
(defrule REASONING::obedient
	(not (obedient))
	(submissive)
	(tolerant ?tolerant)
	(test (> ?tolerant 5))
	=>
	(assert (obedient)))

; posluszny => prawdopodobnie chce byc prowadzony przez zycie
(defrule REASONING::guided-correction
	(not (g-corred))
	(obedient)
	?g <- (guided ?guided)
	=>
	(assert (g-corred))
	(retract ?g)
	(assert (guided (+ ?guided 7))))

; potrafi sie dostosowac => zniesie proporcjonalnie mniejsza temperature
(defrule REASONING::cold
	(not (colded))
	(adaptation ?adaptation)
	?t <- (temperature ?temperature)
	=>
	(assert (colded))
	(retract ?t)
	(assert (temperature ?temperature)))

; umie sie dostosowac do trudnej sytuacji => nie potrzebuje dobrobytu, ani duzej wolnosci
(defrule REASONING::resistant
	(adaptation ?adaptation)
	(test (> ?adaptation 7))
	=>
	(assert (resistant)))

(defrule REASONING::resistant-w
	(not (resistant-wed))
	(resistant)
	?w <- (user-wealth ?wealth)
	=>
	(assert (resistant-wed))
	(retract ?w)
	(assert (user-wealth (- ?wealth 2))))

(defrule REASONING::resistant-f
	(not (resistant-fed))
	(resistant)
	?f <- (user-freedom ?freedom)
	=>
	(assert (resistant-fed))
	(retract ?f)
	(assert (user-freedom (- ?freedom 2))))

; im bardziej tolerancyjny i spoleczny, tym wiecej ludzi potrzebuje
(defrule REASONING::urban
	(not (urbaned))
	(wild ?wild)
	(tolerant ?tolerant)
	?u <- (user-urbanization ?urbanization)
	=>
	(assert (urbaned))
	(retract ?u)
	(assert (user-urbanization (+ ?urbanization (+ ?tolerant (- 5 ?wild))))))


; antyspoleczny i wytrzymaly => moze mieszkac nawet na pustkowiu
(defrule REASONING::wilderness
	(not (wildernessed))
	(resistant)
	(antisocial)
	?u <- (user-urbanization ?)
	=>
	(assert (wildernessed))
	(retract ?u)
	(assert (user-urbanization 0)))

; im wieksza temperatura, tym lagodniejszy klimat; im bardziej lubi wyzwania, tym ostrzejszy klimat moze przetrwac
(defrule REASONING::climate
	(not (climated))
	(temperature ?temperature)
	(challenges ?challenges)
	(wild ?wild)
	?c <- (user-climate ?climate)
	=>
	(assert (climated))
	(retract ?c)
	(bind ?social (- 10 ?wild))
	(assert (user-climate (- 20 ?temperature))))

(defrule REASONING::wealth
	(not (wealthed))
	?w <- (user-wealth ?wealth)
	(challenges ?challenges)
	(guided ?guided)
	(adaptation ?adaptation)
	=>
	(assert (wealthed))
	(retract ?w)
	(assert (user-wealth (+ ?wealth (- ?guided (+ ?adaptation ?challenges))))))

(defrule REASONING::freedom
	(not (freedomed))
	?f <- (user-freedom ?freedom)
	(guided ?guided)
	(adaptation ?adaptation)
	(tolerant ?tolerant)
	=>
	(assert (freedomed))
	(retract ?f)
	(assert (user-freedom (+ ?freedom (- ?tolerant (+ ?guided ?adaptation))))))

(defmodule SOLUTION
	(import MAIN ?ALL)
	(import REASONING ?ALL))

;
; FINAL RULES
;

(defrule SOLUTION::final-decision
	(not (stop ?))
	(not (resistant))
	(user-wealth ?wealth)
	(user-urbanization ?urbanization)
	(user-freedom ?freedom)
	(user-tv ?tourist-value)
	(user-lg ?language-group)
	(user-climate ?climate)
	
	(country (name ?c-name)
		(wealth ?c-wealth)
		(urbanization ?c-urbanization)
		(freedom ?c-freedom)
		(tourist-value ?c-tourist-value)
		(language-group ?language-group)
		(climate ?c-climate))

	(test (<= ?wealth ?c-wealth))
	(test (<= ?urbanization ?c-urbanization))
	(test (<= ?freedom ?c-freedom))
	(test (<= ?tourist-value ?c-tourist-value))
	(test (<= ?climate ?c-climate))
	=>
	(assert (stop ?c-name)))	

(defrule SOLUTION::final-decision-resistant
	(not (stop ?))
	(resistant)
	(user-wealth ?wealth)
	(user-urbanization ?urbanization)
	(user-freedom ?freedom)
	(user-tv ?tourist-value)
	(user-lg ?)
	(user-climate ?climate)
	
	(country (name ?c-name)
		(wealth ?c-wealth)
		(urbanization ?c-urbanization)
		(freedom ?c-freedom)
		(tourist-value ?c-tourist-value)
		(language-group ?)
		(climate ?c-climate))

	(test (<= ?wealth ?c-wealth))
	(test (<= ?urbanization ?c-urbanization))
	(test (<= ?freedom ?c-freedom))
	(test (<= ?tourist-value ?c-tourist-value))
	(test (<= ?climate ?c-climate))
	=>
	(assert (stop ?c-name)))	


(defrule SOLUTION::end
	?s <- (stop ?name)
	=>
	(printout t crlf crlf
		"Nasz cel to " ?name "!" crlf)
	(halt))