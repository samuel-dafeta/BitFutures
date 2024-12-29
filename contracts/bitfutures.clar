;; Title: BitFutures - Decentralized Bitcoin Price Prediction Market
;;
;; A decentralized prediction market for Bitcoin price movements. Users can stake STX
;; to predict whether BTC price will go up or down within a specified timeframe.
;; Winners share the total pool proportionally to their stake, minus platform fees.
;;
;; Security:
;; - Owner-only administrative functions
;; - Oracle-based price resolution
;; - Minimum stake requirements
;; - Fee mechanism for platform sustainability
;; - Claim verification to prevent double-claims

;; Constants 

;; Administrative
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))

;; Error codes
(define-constant err-not-found (err u101))
(define-constant err-invalid-prediction (err u102))
(define-constant err-market-closed (err u103))
(define-constant err-already-claimed (err u104))
(define-constant err-insufficient-balance (err u105))
(define-constant err-invalid-parameter (err u106))

;; State Variables

;; Platform configuration
(define-data-var oracle-address principal 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
(define-data-var minimum-stake uint u1000000) ;; 1 STX minimum stake
(define-data-var fee-percentage uint u2) ;; 2% platform fee
(define-data-var market-counter uint u0)

;; Data Maps

;; Market data structure
(define-map markets
    uint
    {
        start-price: uint,
        end-price: uint,
        total-up-stake: uint,
        total-down-stake: uint,
        start-block: uint,
        end-block: uint,
        resolved: bool
    }
)

;; User predictions tracking
(define-map user-predictions
    {market-id: uint, user: principal}
    {prediction: (string-ascii 4), stake: uint, claimed: bool}
)