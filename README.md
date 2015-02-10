# Chat Correct

[![Gem Version](https://badge.fury.io/rb/chat_correct.svg)](http://badge.fury.io/rb/chat_correct) [![Build Status](https://travis-ci.org/diasks2/chat_correct.png)](https://travis-ci.org/diasks2/chat_correct) [![License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](https://github.com/diasks2/chat_correct/blob/master/LICENSE.txt)

A Ruby gem to help students improve their English. A teacher can correct a student's sentence and this gem will automatically provide information on the type of error (i.e. punctuation, spelling, etc.), the placement of the errors, and the number of errors.

Live Demo: [Chat Correct chat room application](http://www.chat-correct.com)

![](https://s3.amazonaws.com/tm-town-nlp-resources/chat_correct_screenshot.jpg)

##Install

**Ruby**  
*Supports Ruby 2.1.0 and above*
```
gem install chat_correct
```

**Ruby on Rails**  
Add this line to your application’s Gemfile:
```ruby
gem 'chat_correct'
```

## Usage

#### Correct

The correct method returns a hash of the original sentence interleaved with the corrected sentence. The idea is that you can use styling in your output progam to highlight the errors (color, **font weight**, ~~strikethrough~~, etc.).

```ruby
os = "is the, puncttuation are wrong."
cs = "Is the punctuation wrong?"
cc = ChatCorrect::Correct.new(original_sentence: os, corrected_sentence: cs)
cc.correct

# =>  {
#       0 => {
#        'token' => 'is',
#        'type' => 'capitalization_mistake'
#       },
#       1 => {
#        'token' => 'Is',
#        'type' => 'capitalization_correction'
#       },
#       2 => {
#        'token' => 'the',
#        'type' => 'no_mistake'
#       },
#       3 => {
#        'token' => ',',
#        'type' => 'punctuation_mistake'
#       },
#       4 => {
#        'token' => 'puncttuation',
#        'type' => 'spelling_mistake'
#       },
#       5 => {
#        'token' => 'punctuation',
#        'type' => 'spelling_correction'
#       },
#       6 => {
#        'token' => 'are',
#        'type' => 'unnecessary_word_mistake'
#       },
#       7 => {
#        'token' => 'wrong',
#        'type' => 'no_mistake'
#       },
#       8 => {
#        'token' => '.',
#        'type' => 'punctuation_mistake'
#       },
#       9 => {
#        'token' => '?',
#        'type' => 'punctuation_correction'
#       }
#     }

cc.correct[5]['token']
# => 'punctuation'

cc.correct[5]['type']
# => 'spelling_correction'

```

#### Mistakes

The mistakes method returns a hash of each mistake, ordered by its position in the sentence. For each mistake the method returns the `position`, `error_type`, `mistake`, and `correction`.

```ruby
os = "is the, puncttuation are wrong."
cs = "Is the punctuation wrong?"
cc = ChatCorrect::Correct.new(original_sentence: os, corrected_sentence: cs)
cc.mistakes

# =>  {
#       0 => {
#        'position' => 0,
#        'error_type' => 'capitalization',
#        'mistake' => 'is',
#        'correction' => 'Is'
#       },
#       1 => {
#        'position' => 3,
#        'error_type' => 'punctuation',
#        'mistake' => ',',
#        'correction' => ''
#       },
#       2 => {
#        'position' => 4,
#        'error_type' => 'spelling',
#        'mistake' => 'puncttuation',
#        'correction' => 'punctuation'
#       },
#       3 => {
#        'position' => 6,
#        'error_type' => 'unnecessary_word',
#        'mistake' => 'are',
#        'correction' => ''
#       },
#       4 => {
#        'position' => 8,
#        'error_type' => 'punctuation',
#        'mistake' => '.',
#        'correction' => '?'
#       }
#     }

cc.mistakes[4]['correction']
# => '?'

cc.mistakes[1]['mistake']
# => ','
```

#### Mistake Report

The mistake report method returns a hash containing the number of mistakes for each error type.

```ruby
os = "is the, puncttuation are wrong."
cs = "Is the punctuation wrong?"
cc = ChatCorrect::Correct.new(original_sentence: os, corrected_sentence: cs)
cc.mistake_report
# => {
#      'missing_word'     => 0,
#      'unnecessary_word' => 1,
#      'spelling'         => 1,
#      'verb'             => 0,
#      'punctuation'      => 2,
#      'word_order'       => 0,
#      'capitalization'   => 1,
#      'duplicate_word'   => 0,
#      'word_choice'      => 0,
#      'pluralization'    => 0,
#      'possessive'       => 0,
#      'stylistic_choice' => 0
#    }

cc.mistake_report['punctuation']
# => 2
```

#### Number of Mistakes

The number of mistakes method returns the total number of mistakes in the original sentence.

```ruby
os = "is the, puncttuation are wrong."
cs = "Is the punctuation wrong?"
cc = ChatCorrect::Correct.new(original_sentence: os, corrected_sentence: cs)
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

