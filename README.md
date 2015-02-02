# Chat Correct

A Ruby gem to help students improve their English. A teacher can correct a student's sentence and this gem will automatically provide information on the type of error (i.e. punctuation, spelling, etc.), the placement of the errors, and the number of errors.

Live Demo: [Chat Correct chat room application](http://www.chat-correct.com)

![](https://s3.amazonaws.com/tm-town-nlp-resources/chat_correct_screenshot.jpg)

##Install  

**Ruby**  
*Supports Ruby 2.1.5 and above*  
```
gem install chat_correct
```

**Ruby on Rails**  
Add this line to your application’s Gemfile:  
```ruby 
gem 'chat_correct'
```

## Usage

#### Mistake Report

```ruby
os = "is the, puncttuation are wrong."
cs = "Is the punctuation wrong?"
cc = ChatCorrect.new(original_sentence: os, corrected_sentence: cs)
cc.mistake_report
# => { 'missing_word'     => 0, 
#      'unnecessary_word' => 1,
#      'spelling'         => 1,
#      'verb_tense'       => 0,
#      'punctuation'      => 2,
#      'word_order'       => 0,
#      'capitalization'   => 1,
#      'duplicate_word'   => 0,
#      'word_choice'      => 0,
#      'pluralization'    => 0,
#      'possessive'       => 0,
#      'stylistic_choice' => 0
#    }
```

#### Number of Mistakes

```ruby
os = "is the, puncttuation are wrong."
cs = "Is the punctuation wrong?"
cc = ChatCorrect.new(original_sentence: os, corrected_sentence: cs)
cc.number_of_mistakes
# => 5
```

## Contributing

1. Fork it ( https://github.com/diasks2/chat_correct/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The MIT License (MIT)

Copyright (c) 2015 Kevin S. Dias

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.