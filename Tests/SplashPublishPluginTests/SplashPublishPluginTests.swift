/**
*  Splash-plugin for Publish
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import XCTest
import SplashPublishPlugin
import Ink

final class SplashPublishPluginTests: XCTestCase {
    func testHighlightingMarkdown() {
        let parser = MarkdownParser(modifiers: [.splashCodeBlocks()])
        let html = parser.html(from: """
        Some text
        ```
        let int = 7
        ```
        More text
        ```no-highlight
        not.highlighted()
        ```
        """)

        XCTAssertEqual(html, """
        <p>Some text</p><pre><code><span class="keyword">let</span> int = <span class="number">7</span>
        </code></pre><p>More text</p><pre><code class="language-no-highlight">not.highlighted()
        </code></pre>
        """)
    }

    func testInlineMarkdown() {
        let parser = MarkdownParser(modifiers: [.splashInlineCode()])
        let html = parser.html(from: """
        Some text
        `let int = 7`
        """)

        XCTAssertEqual(html, """
        <p>Some text</p><p><code><span class="keyword">let</span> int = <span class="number">7</span></code></p>
        """)
    }

    func testInlineMarkdownNoHighlight() {
        let parser = MarkdownParser(modifiers: [.splashInlineCode()])
        let html = parser.html(from: """
        Some text
        `no-highlight let int = 7`
        """)

        XCTAssertEqual(html, """
        <p>Some text</p><p><code>let int = 7</code></p>
        """)
    }

    static var allTests = [
        ("testHighlightingMarkdown", testHighlightingMarkdown,
         "testInlineMarkdown", testInlineMarkdown )
    ]
}
