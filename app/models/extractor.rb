# uses LLM to extract all the bits relevant to the keywords into a single document.
# Could also be a "summarizer".

# that worked:
# find all datapoints that mention API or automation as a standalone word in the context of
# [INSERT YOUR TOPIC HERE; web or rest apis; ruby design patterns; etc.] and extract the data
# relevant to that data point. if present it should contain
# description, author, and a link for further reading. look through the whole document and all
# sections to find any mentions of the above mentioned keywords:
# ...html...
class Extractor
end
