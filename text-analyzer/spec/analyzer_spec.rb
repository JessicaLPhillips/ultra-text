require "./ultra_text_analyzer"

RSpec.describe UltraTextAnalyzer do
  describe ".analyze" do
    describe "when counting contractible phrases" do
      
      it "should find a word followed by 'is' without punctuation between them" do
        expect(UltraTextAnalyzer.analyze("She is cool")).to include("Contractible phrases: 1")
        expect(UltraTextAnalyzer.analyze("She is late. Is that cool?")).to include("Contractible phrases: 1")
      end

      it "should find ‘not’ preceded by one of its contractible words" do
        expect(UltraTextAnalyzer.analyze("She is not cool.")).to include("Contractible phrases: 2")
        expect(UltraTextAnalyzer.analyze("The Hoosiers have not eaten.")).to include("Contractible phrases: 1")
      end

      it "should find ‘let’ followed by ‘us’" do
        expect(UltraTextAnalyzer.analyze("Let us go to the store")).to include("Contractible phrases: 1")
        expect(UltraTextAnalyzer.analyze("Please let us go.")).to include("Contractible phrases: 1")
      end

      it "should find ‘I’ followed by [have,am]" do
        expect(UltraTextAnalyzer.analyze("I am hungry.")).to include("Contractible phrases: 1")
        expect(UltraTextAnalyzer.analyze("I have no time to spare")).to include("Contractible phrases: 1")
      end

      it "should find ‘have’ preceded by [would, could, should, must, you, we, they]" do
        expect(UltraTextAnalyzer.analyze("You should have come to the party")).to include("Contractible phrases: 1")
      end

      it "should find 'are' when followed by [you, they, we]" do
        expect(UltraTextAnalyzer.analyze("you are going to have a great time")).to include("Contractible phrases: 1")
      end
    end
    let(:long_text) { "Hey how are you doing? Have you seen Bob lately? Lately I heard  he was doing a new job, but I'm not sure what. Susan was in Europe last week for her job for vacation. Have you talked to her? Lately she's been hard to catch up with. What have y'all been doing lately?"}

    it "should return nil when given a non-string argument" do
      results = UltraTextAnalyzer.analyze(3)
      expect(results).to eq(nil)
    end

    it "should output the correct word count" do
      results = UltraTextAnalyzer.analyze("hello, my friend.")
      expect(results).to include("3 words")
    end

    it "should output the correct word count regardless of irregular spacing" do
      results = UltraTextAnalyzer.analyze(" hello, my  friend ")
      expect(results).to include("3 words")
    end  

    it "should output the correct character count" do
      results = UltraTextAnalyzer.analyze("hello, my friend.")
      expect(results).to include("17 characters")
    end

    it "should output the correct space count" do
      results = UltraTextAnalyzer.analyze("hello, my friend.")
      expect(results).to include("2 spaces")
    end

    it "should output the correct space count regardless of irregular spacing" do
      results = UltraTextAnalyzer.analyze(" hello, my  friend  ")
      expect(results).to include ("6 spaces")
     end 

    it "should output the most common word, regardless of capitalization" do
      results = UltraTextAnalyzer.analyze(long_text)
      expect(results).to include("Most common word: lately")
    end

    it "should output the longest word" do
      results = UltraTextAnalyzer.analyze(long_text)
      expect(results).to include("Longest word: vacation")
    end

    it "should output the longest word regardless of adjacent punctuation" do
      results = UltraTextAnalyzer.analyze("sushi bowl...")
      expect(results).to include("Longest word: sushi")
    end
  end
end
