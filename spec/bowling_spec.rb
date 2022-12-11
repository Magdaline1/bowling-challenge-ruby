require 'bowling'

describe Scorecard do

  xcontext 'points' do
    it 'shows zero points overall if player has not scored any points' do
      #gutter game
      io = double :io

      20.times {expect(io).to receive(:gets).and_return("0")}

      result = Scorecard.new(io)

      expect(result.run).to eq 0
    end

    it 'shows the grand total if player has scored points (without bonuses)' do
      io = double :io

      10.times {expect(io).to receive(:gets).and_return("4")
      expect(io).to receive(:gets).and_return("5")}

      result = Scorecard.new(io)

      expect(result.run).to eq 90
    end
  end


  xcontext 'bonuses' do
    it 'gives a bonus where player scores a strike' do
      io = double :io

      9.times {expect(io).to receive(:gets).and_return("10")}
      2.times {expect(io).to receive(:gets).and_return("0")}

      result = Scorecard.new(io)

      expect(result.run).to eq 240
    end

    it 'gives a bonus where player scores a spare' do
      io = double :io

      19.times {expect(io).to receive(:gets).and_return("5")}
      expect(io).to receive(:gets).and_return("0")

      result = Scorecard.new(io)

      expect(result.run).to eq 140
    end
  end


  context '10th frame' do
    it 'allows player to win extra turns if they get a strike' do
      #perfect game
      io = double :io

      10.times {expect(io).to receive(:gets).and_return("10")}
      expect(io).to receive(:puts).with("Bonus round! Enter your score:")
      expect(io).to receive(:gets).and_return("10")
      expect(io).to receive(:puts).with("Wow, extra bonus! Enter your score:")
      expect(io).to receive(:gets).and_return("10")

      result = Scorecard.new(io)

      expect(result.run).to eq 300
    end

    xit 'allows player to win extra turns if they get a strike' do
      io = double :io

      18.times {expect(io).to receive(:gets).and_return("0")}
      expect(io).to receive(:gets).and_return("10")
      expect(io).to receive(:puts).with("Bonus round! Enter your score:")
      expect(io).to receive(:gets).and_return("10")
      expect(io).to receive(:puts).with("Wow, extra bonus! Enter your score:")
      expect(io).to receive(:gets).and_return("10")

      result = Scorecard.new(io)

      expect(result.run).to eq 30
    end

    xit 'allows player to win extra turns if they get a spare' do
      io = double :io

      20.times {expect(io).to receive(:gets).and_return("5")}
      expect(io).to receive(:puts).with("Bonus round! Enter your score:")
      expect(io).to receive(:gets).and_return("10")

      result = Scorecard.new(io)

      expect(result.run).to eq 155
    end

  end
end