/*
 * Copyright (c) 2012 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.grails.plugins.fixedflatfile
/**
 * Used in output formatation. Represents a constant to be printed in output.
 * @author oscar
 *
 */
class Constant extends Command {
	def value
	def align
	def length
	def fill=' '
	String toString() {
		"contant(${value})\n"
	}
	def generate(context,text=''){
		text+value.toString()
	}
	def parse(text,context){
		if (text!=value) throw new RuntimeException("Invalid contant. Expected $value found $text")
		context
	}
}
