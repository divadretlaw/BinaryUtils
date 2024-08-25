//
//  ASCII.swift
//  BinaryUtils
//
//  Created by David Walter on 24.08.24.
//

import Foundation

/// American Standard Code for Information Interchange character encoding
public enum ASCII: UInt8, CaseIterable, Hashable, Equatable, Sendable, CustomStringConvertible {
    /// ASCII code point 'null'.
    case null = 0x00
    /// ASCII code point for 'Start of Heading'.
    case startOfHeading = 0x01
    /// ASCII code point for 'Start of Text'.
    case startOfText = 0x02
    /// ASCII code point for 'End of Text'.
    case endOfText = 0x03
    /// ASCII code point for 'End of Transmision'.
    case endOfTransmission = 0x04
    /// ASCII code point for 'Enquiry'.
    case enquiry = 0x05
    /// ASCII code point for 'Acknowledgement'.
    case acknowledgement = 0x06
    /// ASCII code point for 'Bell'.
    case bell = 0x07
    /// ASCII code point for 'Backsapce'
    case backspace = 0x08
    /// ASCII code point for 'Horizontal Tab'.
    case horizontalTab = 0x09
    /// ASCII code poin for 'Line Feed'.
    case lineFeed = 0x0A
    /// ASCII code point 'Vertical Tab'.
    case verticalTab = 0x0B
    /// ASCII code point for 'Form Feed'.
    case formFeed = 0x0C
    /// ASCII code point for 'Carriage Return'.
    case carriageReturn = 0x0D
    /// ASCII code point for 'Shfit Out'.
    case shiftOut = 0x0E
    /// ASCII code point for 'Shift In'.
    case shiftIn = 0x0F
    /// ASCII code point for 'Data Link Escape'.
    case dataLinkEscape = 0x10
    /// ASCII code point for 'Device Control 1'.
    case deviceControl1 = 0x11
    /// ASCII code point for 'Device Control 2'.
    case deviceControl2 = 0x12
    /// ASCII code point for 'Device Control 3'.
    case deviceControl3 = 0x13
    /// ASCII code poin for 'Device Control 4'.
    case deviceControl4 = 0x14
    /// ASCII code point for 'Negative Acknowledgment'.
    case negativeAcknowledgement = 0x15
    /// ASCII code point for 'Synchronous Idle'.
    case synchronousIdle = 0x16
    /// ASCII code point for 'End of Transmission Block'.
    case endOfTransmissionBlock = 0x17
    /// ASCII code point for 'Cancel'.
    case cancel = 0x18
    /// ASCII code point for 'Medium'.
    case endOfMedium = 0x19
    /// ASCII code point for 'Substitute'.
    case substitute = 0x1A
    /// ASCII code point for 'Escape'.
    case escape = 0x1B
    /// ASCII code point for 'File Separator'.
    case fileSeparator = 0x1C
    /// ASCII code point for 'Group Separator'.
    case groupSeparator = 0x1D
    /// ASCII code point for 'Record Separator'.
    case recordSeparator = 0x1E
    /// ASCII code point for 'Unit Separator'.
    case unitSeparator = 0x1F
    /// ASCII code point for 'Space'.
    case space = 0x20
    /// ASCII code point `!`.
    case exclamationMark = 0x21
    /// ASCII code point `?`.
    case quotationMark = 0x22
    /// ASCII code point `#`.
    case numberSign = 0x23
    /// ASCII code point `$`.
    case dollarSign = 0x24
    /// ASCII code point `%`.
    case percentSign = 0x25
    /// ASCII code point `&`.
    case ampersand = 0x26
    /// ASCII code point `'`.
    case apostrophe = 0x27
    /// ASCII code point `(`.
    case leftParenthesis = 0x28
    /// ASCII code point `)`.
    case rightParenthesis = 0x29
    /// ASCII code point `*`.
    case asterisk = 0x2A
    /// ASCII code point `+`.
    case plus = 0x2B
    /// ASCII code point `,`.
    case comma = 0x2C
    /// ASCII code point `-`.
    case hyphenMinus = 0x2D
    /// ASCII code point `.`.
    case fullStop = 0x2E
    /// ASCII code point `/`.
    case slash = 0x2F
    /// ASCII code point `0`.
    case digit0 = 0x30
    /// ASCII code point `1`.
    case digit1 = 0x31
    /// ASCII code point `2`.
    case digit2 = 0x32
    /// ASCII code point `3`.
    case digit3 = 0x33
    /// ASCII code point `4`.
    case digit4 = 0x34
    /// ASCII code point `5`.
    case digit5 = 0x35
    /// ASCII code point `6`.
    case digit6 = 0x36
    /// ASCII code point `7`.
    case digit7 = 0x37
    /// ASCII code point `8`.
    case digit8 = 0x38
    /// ASCII code point `9`.
    case digit9 = 0x39
    /// ASCII code point `:`.
    case colon = 0x3A
    /// ASCII code point `;`.
    case semicolon = 0x3B
    /// ASCII code point `<`.
    case lessThanSign = 0x3C
    /// ASCII code point `=`.
    case equalSign = 0x3D
    /// ASCII code point `>`.
    case greaterThanSign = 0x3E
    /// ASCII code point `?`.
    case questionMark = 0x3F
    /// ASCII code point `@`.
    case atSign = 0x40
    /// ASCII code point `A`.
    case A = 0x41
    /// ASCII code point `B`.
    case B = 0x42
    /// ASCII code point `C`.
    case C = 0x43
    /// ASCII code point `D`.
    case D = 0x44
    /// ASCII code point `E`.
    case E = 0x45
    /// ASCII code point `F`.
    case F = 0x46
    /// ASCII code point `G`.
    case G = 0x47
    /// ASCII code point `H`.
    case H = 0x48
    /// ASCII code point `I`.
    case I = 0x49
    /// ASCII code point `J`.
    case J = 0x4A
    /// ASCII code point `K`.
    case K = 0x4B
    /// ASCII code point `L`.
    case L = 0x4C
    /// ASCII code point `M`.
    case M = 0x4D
    /// ASCII code point `N`.
    case N = 0x4E
    /// ASCII code point `O`.
    case O = 0x4F
    /// ASCII code point `P`.
    case P = 0x50
    /// ASCII code point `Q`.
    case Q = 0x51
    /// ASCII code point `R`.
    case R = 0x52
    /// ASCII code point `S`.
    case S = 0x53
    /// ASCII code point `T`.
    case T = 0x54
    /// ASCII code point `U`.
    case U = 0x55
    /// ASCII code point `V`.
    case V = 0x56
    /// ASCII code point `W`.
    case W = 0x57
    /// ASCII code point `X`.
    case X = 0x58
    /// ASCII code point `Y`.
    case Y = 0x59
    /// ASCII code point `Z`.
    case Z = 0x5A
    /// ASCII code point `[`.
    case leftSquareBracket = 0x5B
    /// ASCII code point `\`.
    case backslash = 0x5C
    /// ASCII code point `]`.
    case rightSquareBracket = 0x5D
    /// ASCII code point `^`.
    case caret = 0x5E
    /// ASCII code point `_`.
    case underscore = 0x5F
    /// ASCII code point ` ` `.
    case backtick = 0x60
    /// ASCII code point `a`.
    case a = 0x61
    /// ASCII code point `b`.
    case b = 0x62
    /// ASCII code point `c`.
    case c = 0x63
    /// ASCII code point `d`.
    case d = 0x64
    /// ASCII code point `e`.
    case e = 0x65
    /// ASCII code point `f`.
    case f = 0x66
    /// ASCII code point `g`.
    case g = 0x67
    /// ASCII code point `h`.
    case h = 0x68
    /// ASCII code point `i`.
    case i = 0x69
    /// ASCII code point `j`.
    case j = 0x6A
    /// ASCII code point `k`.
    case k = 0x6B
    /// ASCII code point `l`.
    case l = 0x6C
    /// ASCII code point `m`.
    case m = 0x6D
    /// ASCII code point `n`.
    case n = 0x6E
    /// ASCII code point `o`.
    case o = 0x6F
    /// ASCII code point `p`.
    case p = 0x70
    /// ASCII code point `q`.
    case q = 0x71
    /// ASCII code point `r`.
    case r = 0x72
    /// ASCII code point `s`.
    case s = 0x73
    /// ASCII code point `t`.
    case t = 0x74
    /// ASCII code point `u`.
    case u = 0x75
    /// ASCII code point `v`.
    case v = 0x76
    /// ASCII code point `w`.
    case w = 0x77
    /// ASCII code point `x`.
    case x = 0x78
    /// ASCII code point `y`.
    case y = 0x79
    /// ASCII code point `z`.
    case z = 0x7A
    /// ASCII code point `{`.
    case leftCurlyBracket = 0x7B
    /// ASCII code point `|`.
    case verticalBar = 0x7C
    /// ASCII code point `}`.
    case rightCurlyBracket = 0x7D
    /// ASCII code point `~`.
    case tilde = 0x7E
    /// ASCII code point for 'Delete'.
    case delete = 0x7F
    
    /// Checks if the ASCII code point is printable
    var isPrintable: Bool {
        switch self.rawValue {
        case 0x20...0x7E:
            return true
        default:
            return false
        }
    }
    
    /// The C escape sequence for this code point
    public var cEscapeSequence: String {
        switch self {
        case .null:
            "\\0"
        case .bell:
            "\\a"
        case .backspace:
            "\\b"
        case .horizontalTab:
            "\\t"
        case .lineFeed:
            "\\n"
        case .verticalTab:
            "\\v"
        case .formFeed:
            "\\f"
        case .carriageReturn:
            "\\r"
        case .escape:
            "\\e"
        case .apostrophe:
            "\\'"
        case .quotationMark:
            "\\\""
        case .questionMark:
            "\\?"
        default:
            "\\x\(String(format: "%02x", rawValue))"
        }
    }
    
    // MARK: - CustomStringConvertible
    
    public var description: String {
        switch self {
        case .null:
            "␀"
        case .startOfHeading:
            "␁"
        case .startOfText:
            "␂"
        case .endOfText:
            "␃"
        case .endOfTransmission:
            "␄"
        case .enquiry:
            "␅"
        case .acknowledgement:
            "␆"
        case .bell:
            "␇"
        case .backspace:
            "␈"
        case .horizontalTab:
            "␉"
        case .lineFeed:
            "␊"
        case .verticalTab:
            "␋"
        case .formFeed:
            "␌"
        case .carriageReturn:
            "␍"
        case .shiftOut:
            "␎"
        case .shiftIn:
            "␏"
        case .dataLinkEscape:
            "␐"
        case .deviceControl1:
            "␑"
        case .deviceControl2:
            "␒"
        case .deviceControl3:
            "␓"
        case .deviceControl4:
            "␔"
        case .negativeAcknowledgement:
            "␕"
        case .synchronousIdle:
            "␖"
        case .endOfTransmissionBlock:
            "␗"
        case .cancel:
            "␘"
        case .endOfMedium:
            "␙"
        case .substitute:
            "␚"
        case .escape:
            "␛"
        case .fileSeparator:
            "␜"
        case .groupSeparator:
            "␝"
        case .recordSeparator:
            "␞"
        case .unitSeparator:
            "␟"
        case .delete:
            "␡"
        default:
            Character(ascii: self).description
        }
    }
}
