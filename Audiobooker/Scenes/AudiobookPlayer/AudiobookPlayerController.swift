//
//  AudiobookPlayer.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 21/09/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

protocol IAudiobookPlayerUI
{
    var selectChapterHandler: ((Int) -> (Void))? { get set }
    var playTapHandler: VoidHandler? { get set }
    var rollBackTapHandler: VoidHandler? { get set }
    var rollForwardTapHandler: VoidHandler? { get set }

    func show(_ bookInfo: AudioBook)
    func show(_ chapters: [Chapter])
}

class AudiobookPlayerController: DataViewController, IAudiobookPlayerUI
{
    @IBOutlet weak var panel: UIView!
    @IBOutlet weak var audiobookInfoView: AudiobookInfoView!
    @IBOutlet weak var collectionView: UICollectionView!

    private var chapters: [Chapter] = []

    lazy var audiobookPlayerPresenter: IPresenter = {
        guard let audiobook = self.data as? AudioBook else {
            fatalError()
        }

        let progressHelper = AudiobookProgressHelper(storage: DefaultsStorage())

        let interactor = ChapterListInteractor(audioBook: audiobook,
                                               audiobookProgressHelper: progressHelper)

        return AudiobookPlayerPresenter(audiobook: audiobook,
                                        ui: self,
                                        interactor: interactor)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
        audiobookPlayerPresenter.viewIsReady()
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: IAudiobookPlayerUI

    var selectChapterHandler: ((Int) -> (Void))?
    var playTapHandler: VoidHandler?
    var rollBackTapHandler: VoidHandler?
    var rollForwardTapHandler: VoidHandler?

    func show(_ bookInfo: AudioBook) {
        audiobookInfoView.showInfo(with: bookInfo)
    }

    func show(_ chapters: [Chapter]) {
        self.chapters = chapters
        self.collectionView.reloadData()
    }
}

extension AudiobookPlayerController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chapters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChapterCollectionCell", for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        guard let cell = cell as? ChapterCollectionCell else {
            assertionFailure()
            return
        }

        cell.set(index: indexPath.row + 1)

        let chapter = chapters[indexPath.row]

        guard let chapterProgress = chapter.progress?.progress else {
            return
        }

        cell.set(progress: chapterProgress)
    }
}

private extension AudiobookPlayerController
{
    func configure() {
        UIViewDecorator.decorate(view: panel, config: .darkBlur)
    }
}
