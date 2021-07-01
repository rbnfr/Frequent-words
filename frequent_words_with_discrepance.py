# Frequent_words_with_discrepance.py
import bio
import pprint

sequence = "ACGTTGCATGTCGCATGATGCATGAGAGCTCGCATGCATGTCGCATGATGCGTTGCATGTCGCATGATGCATGAGAGACTTGATAGCGCTAGCGTAGCGCGTATGCGTAGGGGCGTATTATTATCGAGAACGGCGCCCTATAGGCGTAGCG"
k = 5
discrepancies = 2
repeated_sequences, frequency = bio.palabrasfrecuentesdiscrepancias(sequence,k,discrepancies)

file = "prueba.fasta"

print ("In the following sequence: ", sequence, ", the following groups of ", k, " nucleotids are repeated with higher frequency if we admit ", discrepancies, " discrepancies: \n", sep="")
print ("Repeated sequences:",repeated_sequences,"\nFrequency:", frequency)

pprint.pprint(bio.cargarfasta(file))